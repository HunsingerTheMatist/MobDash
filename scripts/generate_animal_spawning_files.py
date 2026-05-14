"""
Generates files for the custom passive-mob spawning system.

Inputs:
  overworld_biomes/<biome>.json
      Pristine vanilla biome JSONs. Refresh via fetch_overworld_biomes.py.

Outputs (all auto-overwritten on every run):
  data/mob_dash/tags/worldgen/biome/spawns/<animal>.json
      Per-animal biome tags (kept as a documentation/lookup convenience).
  data/mob_dash/tags/worldgen/biome/no_animal_spawns.json
      Biomes that natively have no creature spawns (used by check_position fast-path).
  data/mob_dash/tags/worldgen/biome/polar_bears_alt_biomes.json
      Biomes where polar bears can spawn on the alternate (ice) block tag.
  data/mob_dash/tags/worldgen/biome/animal_spawn_groups/<canonical>.json
      Per multi-biome group (biomes with identical animal spawn lists).
  data/mob_dash/function/game/animals/spawn/initialize_weights.mcfunction
      Sets per-(canonical, animal) weights on the `animal_weight` scoreboard.
      Called from animals/load.mcfunction (which also creates objectives,
      sets defaults, and calls refresh_weight_sums).
  data/mob_dash/function/game/animals/spawn/refresh_weight_sums.mcfunction
      Recomputes #<canonical>_total animal_weight by summing the per-animal
      weights. Run on load (and after any change to weights).
  data/mob_dash/function/game/animals/spawn/pick_for_biome.mcfunction
      Routes to a per-canonical picker. Singletons match by `if biome ~ ~ ~
      minecraft:<biome>`; multi-biome groups match via the animal_spawn_groups tag.
  data/mob_dash/function/game/animals/spawn/biome/<canonical>.mcfunction
      Per-canonical cumulative-weight dispatch. Picks one animal, runs its summon.
  data/mob_dash/function/game/animals/spawn/summon/<animal>[ _pack<n> | _pack<n>-<m> ].mcfunction
      Per-(animal, pack-range) terrain checks + summon (with optional baby roll,
      tally, animal-ID setter, and sentinel-guarded pack-attempts roll).
      The _pack suffix is omitted iff min == max == 1 (no pack follow-up).
  data/mob_dash/function/game/animals/spawn/pack/pick_for_animal.mcfunction
      Pack-attempt dispatcher: routes from #picked_animal_id to a summon variant
      of the same species (re-checking the per-animal biome tag at the new pos).
  data/mob_dash/function/game/animals/debug/decode_animal_name.mcfunction
      Debug helper: decodes #picked_animal_id back to a display name on
      Debug.AnimalName for spawn_print's tellraw output.

Filters:
  - Only the "creature" spawn category is read.
  - Duplicates (same animal listed twice in one biome's spawners) are summed.

Run from project root:
    py generate_animal_spawning_files.py
"""
import json
import math
import sys
from collections import defaultdict
from pathlib import Path

SCRIPT_DIR = Path(__file__).resolve().parent
ROOT = SCRIPT_DIR.parent  # datapack root (one level up from scripts/)
BIOME_DIR = SCRIPT_DIR / "overworld_biomes"

# Hitbox (width, height) per mob; loaded from mob_hitboxes.json (refresh via
# fetch_mob_hitboxes.py). Block-under tags and per-mob spawn quirks below stay
# hardcoded — they live in Java source and have no public data feed.
HITBOX_FILE = SCRIPT_DIR / "mob_hitboxes.json"


def load_mob_hitboxes() -> dict[str, tuple[float, float]]:
    if not HITBOX_FILE.is_file():
        sys.exit(f"{HITBOX_FILE.name} not found. Run fetch_mob_hitboxes.py first.")
    raw = json.loads(HITBOX_FILE.read_text(encoding="utf-8"))
    return {mob: (float(e["width"]), float(e["height"])) for mob, e in raw.items()}


MOB_HITBOX = load_mob_hitboxes()

MOB_BLOCK_UNDER = {
    "armadillo":  ["#minecraft:armadillo_spawnable_on"],
    "camel":      ["#minecraft:camels_spawnable_on"],
    "chicken":    ["#minecraft:animals_spawnable_on"],
    "cow":        ["#minecraft:animals_spawnable_on"],
    "donkey":     ["#minecraft:animals_spawnable_on"],
    "fox":        ["#minecraft:foxes_spawnable_on"],
    "frog":       ["#minecraft:frogs_spawnable_on"],
    "goat":       ["#minecraft:goats_spawnable_on"],
    "horse":      ["#minecraft:animals_spawnable_on"],
    "llama":      ["#minecraft:animals_spawnable_on"],
    "mooshroom":  ["#minecraft:mooshrooms_spawnable_on"],
    "panda":      ["#minecraft:animals_spawnable_on"],
    "parrot":     ["#minecraft:parrots_spawnable_on"],
    "pig":        ["#minecraft:animals_spawnable_on"],
    "polar_bear": ["#minecraft:animals_spawnable_on"],  # alternate (ice) is biome-gated; see write_summon_functions
    "rabbit":     ["#minecraft:rabbits_spawnable_on"],
    "sheep":      ["#minecraft:animals_spawnable_on"],
    "turtle":     ["minecraft:sand"],
    "wolf":       ["#minecraft:wolves_spawnable_on"],
}

MOB_NEVER_BABY = {"camel", "frog", "turtle"}

# Polar bears can also spawn on ice (#polar_bears_spawnable_on_alternate), but only in
# frozen_ocean / deep_frozen_ocean. In other snowy biomes they're restricted to
# #animals_spawnable_on. Mirrors vanilla PolarBear.checkPolarBearSpawnRules.
POLAR_BEAR_ALT_TAG = "#minecraft:polar_bears_spawnable_on_alternate"
POLAR_BEAR_ALT_BIOMES = ["minecraft:frozen_ocean", "minecraft:deep_frozen_ocean"]

TAGS_DIR = ROOT / "data" / "mob_dash" / "tags" / "worldgen" / "biome" / "spawns"
SPAWN_DIR = ROOT / "data" / "mob_dash" / "function" / "game" / "animals" / "spawn"
INIT_WEIGHTS_FN = SPAWN_DIR / "initialize_weights.mcfunction"


CUSTOM_BIOME_DIR = ROOT / "data" / "minecraft" / "worldgen" / "biome"


def collect_creature_spawns() -> tuple[
    dict[str, list[str]],
    dict[str, list[tuple[str, int, int, int]]],
    list[str],
]:
    """
    Returns:
      animal_to_biomes  -- {animal_id: [namespaced biome ids, sorted]}
      biome_to_animals  -- {biome_short: [(animal_id, weight, min, max), sorted by animal]}
                           — only biomes with at least one creature entry
      no_spawn_biomes   -- ['minecraft:<biome>', ...] for overworld biomes whose
                           effective creature list is empty (used for the
                           no_animal_spawns biome tag)

    For each overworld biome, prefers data/minecraft/worldgen/biome/<biome>.json
    (the datapack's custom override) over the vanilla copy in overworld_biomes/
    when both exist — the override is what actually drives spawns at runtime.

    Duplicate entries within a biome (same animal listed twice) are summed for weight
    and the broadest (min, max) is kept — this matches how vanilla resolves duplicates
    (last write wins for min/max, but in practice no vanilla biome has duplicates).
    """
    if not BIOME_DIR.is_dir():
        sys.exit(f"overworld_biomes/ not found at {BIOME_DIR}. "
                 "Run fetch_overworld_biomes.py first.")

    animal_to_biomes: dict[str, set[str]] = defaultdict(set)
    biome_to_animals: dict[str, list[tuple[str, int, int, int]]] = {}
    no_spawn_biomes: list[str] = []

    for biome_path in sorted(BIOME_DIR.glob("*.json")):
        biome_short = biome_path.stem
        # Custom override takes priority — that's the biome the datapack actually
        #  ships, so its spawner list is the one in effect at runtime.
        override = CUSTOM_BIOME_DIR / f"{biome_short}.json"
        source = override if override.is_file() else biome_path
        with source.open(encoding="utf-8") as f:
            data = json.load(f)
        animal_data: dict[str, tuple[int, int, int]] = {}  # animal -> (weight, min, max)
        for entry in data.get("spawners", {}).get("creature", []):
            a = entry["type"]
            w = entry["weight"]
            mn = entry.get("minCount", 1)
            mx = entry.get("maxCount", 1)
            if a in animal_data:
                pw, pmn, pmx = animal_data[a]
                animal_data[a] = (pw + w, min(pmn, mn), max(pmx, mx))
            else:
                animal_data[a] = (w, mn, mx)
        if not animal_data:
            no_spawn_biomes.append(f"minecraft:{biome_short}")
            continue
        biome_to_animals[biome_short] = sorted(
            (a, w, mn, mx) for a, (w, mn, mx) in animal_data.items()
        )
        for animal in animal_data:
            animal_to_biomes[animal].add(f"minecraft:{biome_short}")

    return (
        {a: sorted(b) for a, b in animal_to_biomes.items()},
        biome_to_animals,
        sorted(no_spawn_biomes),
    )


def wipe_dir(d: Path, pattern: str) -> None:
    if d.is_dir():
        for f in d.glob(pattern):
            f.unlink()


def short(animal_id: str) -> str:
    return animal_id.removeprefix("minecraft:")


def derive_group_canonical(members: list[str]) -> str:
    """Returns the canonical name for the picker (filename, scoreboard scope, tag name).
    Singletons return the member name itself. Multi-biome groups derive a descriptive
    '<common-tokens>_group' from the underscore-separated tokens shared across all
    members (e.g. {windswept_forest, windswept_hills} → 'windswept_group';
    {birch_forest, dark_forest, old_growth_birch_forest} → 'forest_group').
    Falls back to '<alphabetically-first>_group' when no tokens are shared."""
    if len(members) == 1:
        return members[0]
    token_lists = [m.split("_") for m in members]
    first = token_lists[0]
    others = [set(t) for t in token_lists[1:]]
    common = [t for t in first if all(t in s for s in others)]
    if common:
        return "_".join(common) + "_group"
    return sorted(members)[0] + "_group"


def find_animal_spawn_groups(
    biome_to_animals: dict[str, list[tuple[str, int, int, int]]],
) -> tuple[dict[str, list[str]], dict[str, str]]:
    """Group biomes by identical (animal, weight, min, max) signature. Biomes that
    share the same weights but differ in any pack range fall into separate groups —
    pack ranges affect which summon variant the per-biome dispatcher calls.

    Returns:
      canonical_to_members  {canonical: sorted [members]} for every biome (singletons too).
      biome_to_canonical    {biome: canonical} for every biome.
    """
    sig_to_biomes: dict[tuple[tuple[str, int, int, int], ...], list[str]] = defaultdict(list)
    for biome, animals in biome_to_animals.items():
        sig_to_biomes[tuple(animals)].append(biome)
    canonical_to_members: dict[str, list[str]] = {}
    biome_to_canonical: dict[str, str] = {}
    for biomes in sig_to_biomes.values():
        members = sorted(biomes)
        canonical = derive_group_canonical(members)
        canonical_to_members[canonical] = members
        for b in members:
            biome_to_canonical[b] = canonical
    return canonical_to_members, biome_to_canonical


def write_animal_tags(animal_to_biomes: dict[str, list[str]]) -> None:
    TAGS_DIR.mkdir(parents=True, exist_ok=True)
    wipe_dir(TAGS_DIR, "*.json")
    for animal, biomes in sorted(animal_to_biomes.items()):
        out = TAGS_DIR / f"{short(animal)}.json"
        with out.open("w", encoding="utf-8") as f:
            json.dump({"values": biomes}, f, indent=2)
            f.write("\n")
    print(f"  wrote {len(animal_to_biomes)} per-animal biome tags")


def write_initialize_weights(
    biome_to_animals: dict[str, list[tuple[str, int, int, int]]],
    canonical_to_members: dict[str, list[str]],
) -> None:
    INIT_WEIGHTS_FN.parent.mkdir(parents=True, exist_ok=True)
    lines = [
        "# Auto-generated. Sets per-(canonical, animal) animal spawn weights on the",
        "#  `animal_weight` scoreboard. Biomes with identical animal spawn lists share",
        "#  scores under a single canonical (see animal_spawn_groups tags). Singletons",
        "#  use the biome name as the canonical; multi-biome groups use a derived",
        "#  '<common-tokens>_group' name",
        "# Caller 'animals/load' creates the objective and calls",
        "#  'refresh_weight_sums' afterward",
        "# Source: vanilla creature spawn data extracted from overworld_biomes/",
        "",
    ]
    total = 0
    for canonical, members in sorted(canonical_to_members.items()):
        # All members share an identical signature, so any member's weights work.
        animal_entries = biome_to_animals[members[0]]
        for animal, weight, _, _ in animal_entries:
            lines.append(f"scoreboard players set #{canonical}_{short(animal)} animal_weight {weight}")
            total += 1
        lines.append("")
    # Drop the trailing blank line so the file doesn't end with a newline.
    while lines and lines[-1] == "":
        lines.pop()
    INIT_WEIGHTS_FN.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(f"  wrote initialize_weights.mcfunction ({total} per-(canonical,animal) weight setters "
          f"across {len(canonical_to_members)} canonicals)")


def write_refresh_weight_sums(
    biome_to_animals: dict[str, list[tuple[str, int, int, int]]],
    canonical_to_members: dict[str, list[str]],
) -> None:
    out = SPAWN_DIR / "refresh_weight_sums.mcfunction"
    out.parent.mkdir(parents=True, exist_ok=True)
    lines = [
        "# Auto-generated. Recomputes #<canonical>_total animal_weight by summing the",
        "#  per-animal weights for that canonical. Biomes with identical animal spawn",
        "#  lists share a canonical's total via the picker dispatch",
        "# Run on load and after any change to per-animal weights",
        "",
    ]
    for canonical, members in sorted(canonical_to_members.items()):
        animal_entries = biome_to_animals[members[0]]
        lines.append(f"scoreboard players set #{canonical}_total animal_weight 0")
        for animal, _, _, _ in animal_entries:
            lines.append(
                f"scoreboard players operation #{canonical}_total animal_weight "
                f"+= #{canonical}_{short(animal)} animal_weight"
            )
        lines.append("")
    out.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(f"  wrote refresh_weight_sums.mcfunction")


def write_pick_for_biome(
    canonical_to_members: dict[str, list[str]],
) -> None:
    out = SPAWN_DIR / "pick_for_biome.mcfunction"
    out.parent.mkdir(parents=True, exist_ok=True)
    lines = [
        "# Auto-generated. Routes to the per-biome animal picker based on the biome at",
        "#  the current executor position. Biomes with identical animal spawn lists share",
        "#  a picker — for those, dispatch is via the matching",
        "#  #mob_dash:animal_spawn_groups/<canonical> tag rather than per-biome checks",
        "# Runs at the spawn position",
        "",
    ]
    # Multi-biome groups first (one tag check matches several biomes — fail-fast for
    #  the most common biome families), then the singletons.
    groups = sorted((c, m) for c, m in canonical_to_members.items() if len(m) > 1)
    singletons = sorted((c, m) for c, m in canonical_to_members.items() if len(m) == 1)
    for canonical, _ in groups:
        lines.append(
            f"execute if biome ~ ~ ~ #mob_dash:animal_spawn_groups/{canonical} "
            f"run return run function mob_dash:game/animals/spawn/biome/{canonical}"
        )
    if groups and singletons:
        lines.append("")
    for canonical, members in singletons:
        biome = members[0]
        lines.append(
            f"execute if biome ~ ~ ~ minecraft:{biome} "
            f"run return run function mob_dash:game/animals/spawn/biome/{canonical}"
        )
    # No biome matched. Theoretically unreachable: the no_creature_spawns tag check in
    #  check_position covers all overworld biomes without creatures, and the no-spawn-list
    #  is auto-generated to be exhaustive. If execution reaches this point, something is
    #  stale — log it under debug so the issue is visible.
    lines.append("")
    lines.append("return -18")
    out.write_text("\n".join(lines) + "\n", encoding="utf-8")
    singletons = sum(1 for m in canonical_to_members.values() if len(m) == 1)
    groups = len(canonical_to_members) - singletons
    print(f"  wrote pick_for_biome.mcfunction "
          f"({singletons} biome routes + {groups} group-tag routes)")


def variant_filename(animal_short: str, mn: int, mx: int) -> str:
    """Summon filename for an (animal, min, max) variant.
    - min == max == 1 → '<animal>' (no _pack suffix; no pack-attempts roll)
    - min == max > 1  → '<animal>_pack<min>'
    - min < max       → '<animal>_pack<min>-<max>'"""
    if mn == 1 and mx == 1:
        return animal_short
    if mn == mx:
        return f"{animal_short}_pack{mn}"
    return f"{animal_short}_pack{mn}-{mx}"


def assign_animal_ids(animal_to_biomes: dict[str, list[str]]) -> dict[str, int]:
    """Stable integer ID per animal (alphabetical, starting at 1). Used by
    summon files to record which species was picked, so pack/pick_for_animal
    can re-dispatch to the same species on subsequent pack attempts."""
    return {short(a): i + 1 for i, a in enumerate(sorted(animal_to_biomes))}


def write_per_biome_functions(
    biome_to_animals: dict[str, list[tuple[str, int, int, int]]],
    canonical_to_members: dict[str, list[str]],
) -> None:
    biome_dir = SPAWN_DIR / "biome"
    biome_dir.mkdir(parents=True, exist_ok=True)
    wipe_dir(biome_dir, "*.mcfunction")
    for canonical, members in sorted(canonical_to_members.items()):
        animal_entries = biome_to_animals[members[0]]
        out = biome_dir / f"{canonical}.mcfunction"
        if len(members) == 1:
            used_by = f"# Used by: minecraft:{members[0]}"
        else:
            used_by = ("# Used by: "
                       + ", ".join(f"minecraft:{b}" for b in members)
                       + " (identical animal spawn weights)")
        lines = [
            "# Auto-generated. Picks an animal to spawn at the current position via",
            "#  cumulative-weight random selection, then runs that animal's summon function",
            used_by,
            "",
            "execute store result score #pick_roll animal_weight run random value 0..1000000",
            f"scoreboard players operation #pick_roll animal_weight %= #{canonical}_total animal_weight",
            "",
        ]
        for animal, _, mn, mx in animal_entries:
            a = short(animal)
            variant = variant_filename(a, mn, mx)
            lines.append(
                f"execute if score #pick_roll animal_weight < #{canonical}_{a} animal_weight "
                f"run return run function mob_dash:game/animals/spawn/summon/{variant}"
            )
            lines.append(
                f"scoreboard players operation #pick_roll animal_weight -= #{canonical}_{a} animal_weight"
            )
        # Defensive: returns -19 if execution falls through. Cumulative-weight modulo math
        #  should always pick a branch, so reaching here means the per-biome weights are
        #  stale or zero — surfaces as "biome picker fall-through" in debug output.
        lines.append("")
        lines.append("return -19")
        out.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(f"  wrote {len(canonical_to_members)} per-biome dispatch functions "
          f"(one per canonical biome; non-canonicals share via group tag)")


def fmt_offset(n: int) -> str:
    """Format an axis offset as a Minecraft relative coord component (~, ~1, ~-1, ...)."""
    if n == 0:
        return "~"
    return f"~{n}"


def fmt_num(f: float) -> str:
    """Format a number for inline use in mcfunction (e.g. selector args, NBT).
    Strips redundant trailing zeros / decimals (1.0 → '1', 0.7 → '0.7')."""
    if f == int(f):
        return str(int(f))
    return f"{f:g}"


def fmt_offset_f(f: float) -> str:
    """Float variant of fmt_offset for fractional relative coords (~, ~0.5, ~-0.65, ...)."""
    if f == 0:
        return "~"
    return f"~{fmt_num(f)}"


def entity_overlap_check_line(width: float, height: float, center_xz: float) -> str:
    """Builds the entity-AABB-overlap check line for a summon file.

    Selector-volume width is `|d| + 1` (per EntitySelectorParser.createAabb), so we
    clamp to 1-block minimum and set d = search_width - 1 to fit the mob's AABB
    snugly. For sub-1-block mobs (chicken, frog, etc.) the search box is slightly
    larger than the AABB — unavoidable, but a 1-block box is still a tight check.

    Executor is the spawn-block corner (`~ ~ ~`). The summon happens at `(center_xz,
    0, center_xz)` relative to that corner; we center the search box on the same
    point.
    """
    search_w = max(width, 1.0)
    search_h = max(height, 1.0)
    ox = center_xz - search_w / 2
    dx = dz = search_w - 1
    dy = search_h - 1
    return (
        f"execute positioned {fmt_offset_f(ox)} ~ {fmt_offset_f(ox)} "
        f"if entity @n[type=!#mob_dash:doesnt_block_spawns,dx={fmt_num(dx)},dy={fmt_num(dy)},dz={fmt_num(dz)}] "
        f"run return -22"
    )


def overlap_cells(width: float, center_xz: float) -> list[int]:
    """Block offsets along one horizontal axis that a hitbox of width `width`
    centered at `center_xz` (0.0 = block corner, 0.5 = block center) overlaps."""
    half = width / 2
    return list(range(math.floor(center_xz - half), math.floor(center_xz + half - 1e-9) + 1))


def best_center_xz(width: float) -> float:
    """Returns 0.5 (block center) or 0.0 (block corner) — whichever overlaps fewer
    blocks per axis. Ties go to center (closer to vanilla spawn positioning)."""
    corner_n = len(overlap_cells(width, 0.0))
    center_n = len(overlap_cells(width, 0.5))
    return 0.5 if center_n <= corner_n else 0.0


def hitbox_clearance_offsets(width: float, height: float, center_xz: float) -> list[tuple[int, int, int]]:
    """Block offsets (dx, dy, dz) that the mob's hitbox intersects, centered at
    (`center_xz`, 0, `center_xz`) and extending up by `height`. The center-bottom
    cell (0,0,0) is omitted — it's already verified by check_position."""
    horiz = overlap_cells(width, center_xz)
    vert = list(range(math.ceil(height) or 1))
    cells = [(dx, dy, dz) for dy in vert for dx in horiz for dz in horiz]
    return [c for c in cells if c != (0, 0, 0)]


def write_summon_functions(
    animal_to_biomes: dict[str, list[str]],
    biome_to_animals: dict[str, list[tuple[str, int, int, int]]],
    animal_ids: dict[str, int],
) -> None:
    """Emit one summon file per (animal, min, max) variant present across biomes.

    Each file:
      - sets Debug.AnimalName (debug-gated)
      - block-under check (return -21 on fail)
      - hitbox clearance check (return -20 on fail)
      - bumps the per-animal tally
      - sets #picked_animal_id to the animal's ID
      - rolls #pack_attempts to (min-1)..(max-1) iff sentinel == -1
        (omitted entirely for min=max=1 variants — those never enter pack flow)
      - runs the summon command (with baby roll for mobs vanilla allows as babies)
    """
    summon_dir = SPAWN_DIR / "summon"
    summon_dir.mkdir(parents=True, exist_ok=True)
    wipe_dir(summon_dir, "*.mcfunction")
    missing = [short(a) for a in animal_to_biomes if short(a) not in MOB_HITBOX]
    if missing:
        sys.exit(f"Missing MOB_HITBOX/MOB_BLOCK_UNDER spec for: {', '.join(missing)}. "
                 f"Add entries to the dicts at the top of {Path(__file__).name}.")

    # Gather the distinct (animal, min, max) variants seen across biomes.
    variants: set[tuple[str, int, int]] = set()
    for entries in biome_to_animals.values():
        for animal, _, mn, mx in entries:
            variants.add((short(animal), mn, mx))

    for a, mn, mx in sorted(variants):
        animal_id_namespaced = f"minecraft:{a}"
        width, height = MOB_HITBOX[a]
        under_tags = MOB_BLOCK_UNDER[a]
        center_xz = best_center_xz(width)
        clearance = hitbox_clearance_offsets(width, height, center_xz)
        summon_pos = "~0.5 ~ ~0.5" if center_xz == 0.5 else "~ ~ ~"

        if a == "polar_bear":
            under_desc = (
                f"{POLAR_BEAR_ALT_TAG} in #mob_dash:polar_bears_alt_biomes, BUT "
                f"{under_tags[0]} in all others"
            )
        else:
            under_desc = " OR ".join(under_tags)
        if mn == mx == 1:
            pack_desc = "Pack size: 1 (no pack-spawning follow-up)"
        elif mn == mx:
            pack_desc = f"Pack size: {mn} ({mn - 1} pack-attempts after this spawn)"
        else:
            pack_desc = (f"Pack size: {mn}..{mx} ({mn - 1}..{mx - 1} pack-attempts "
                         f"after this spawn)")
        lines = [
            f"# Auto-generated. Spawns a {a} at the current position if surface and clearance pass",
            f"# Hitbox {width}w x {height}h. Block under: {under_desc}",
            f"# {pack_desc}",
            "",
            f"scoreboard players set #picked_animal_id md_state {animal_ids[a]}",
            "",
        ]

        # Block-under check (return -21 = "block under invalid for this mob").
        if a == "polar_bear":
            # (animals_spawnable_on) OR (alternate AND biome in #polar_bears_alt_biomes).
            #  Encoded as two `unless`-chains; together they admit (primary) OR (alt AND tag).
            primary = under_tags[0]
            lines.append(
                f"execute if biome ~ ~ ~ #mob_dash:polar_bears_alt_biomes "
                f"unless block ~ ~-1 ~ {POLAR_BEAR_ALT_TAG} run return -21"
            )
            lines.append(
                f"execute unless biome ~ ~ ~ #mob_dash:polar_bears_alt_biomes "
                f"unless block ~ ~-1 ~ {primary} run return -21"
            )
        else:
            # Chained `unless` acts as AND of negations: fails iff the block is in NONE of
            #  the listed tags. For mobs with a single tag this is just one `unless`.
            under_clauses = " ".join(f"unless block ~ ~-1 ~ {tag}" for tag in under_tags)
            lines.append(f"execute {under_clauses} run return -21")

        # Body clearance — each cell the hitbox intersects (beyond center) must be
        #  non-colliding. Uses the looser #mob_dash:no_collision tag rather than
        #  #mob_dash:allow_spawning_inside because the "no damage / no liquid"
        #  restriction only applies to the body block (already validated by
        #  check_position); pass-through cells just need a non-colliding block.
        # Returns -20 (same code as body-block fail) — both are "terrain blocks the
        #  mob from fitting", not worth distinguishing in debug output.
        if len(clearance) != 0:
            lines.append("")
        for dx, dy, dz in clearance:
            lines.append(
                f"execute unless block {fmt_offset(dx)} {fmt_offset(dy)} {fmt_offset(dz)} "
                f"#mob_dash:no_collision run return -20"
            )

        # Emit the hitbox-collision check with an explanatory comment so the
        #  d=0 case (which means "1-block-wide", not "zero-wide") isn't mystifying
        #  to a reader skimming the file.
        lines.append("")
        lines.append("# Hitbox collision check. Selector-volume span per axis is |d|+1, so")
        lines.append("#  dx=0 → 1-block-wide search. Sized to this mob's hitbox (1-block min)")
        lines.append(entity_overlap_check_line(width, height, center_xz))

        # All checks passed — count toward the per-animal tally. ($-prefix so the
        #  fakeplayer can be displayed in a sidebar/list scoreboard.)
        lines.append("")
        lines.append(f"scoreboard players add ${a} md_animal_spawns 1")

        # Pack-attempts roll, gated on #doing_pack_spawn so pack/validate_and_summon's
        #  re-entry via the same summon file doesn't re-roll. try_spawn sets the flag
        #  to 0 (initial spawn → roll) and pack/try_spawn sets it to 1 (pack repeat →
        #  skip). min=max=1 variants omit this entirely — #pack_attempts stays at 0,
        #  which fails the `>0` gate in validate_and_summon → no pack flow.
        if not (mn == 1 and mx == 1):
            attempts_min, attempts_max = mn - 1, mx - 1
            if attempts_min == attempts_max:
                roll_cmd = f"scoreboard players set #pack_attempts md_state {attempts_min}"
            else:
                roll_cmd = (f"execute store result score #pack_attempts md_state "
                            f"run random value {attempts_min}..{attempts_max}")
            lines.append(
                f"execute if score #doing_pack_spawn md_state matches 0 run {roll_cmd}"
            )

        # Summon, with optional baby roll for mobs that vanilla allows to spawn as babies.
        # md_custom_spawned identifies mobs created by this spawn system; the
        #  md_structure_persistence_checked tag pre-empts the structure-persistence
        #  scan since custom-spawned mobs aren't in any structure.
        nbt_adult = '{Tags: [md_custom_spawned, md_structure_persistence_checked]}'
        nbt_baby = '{Age:-24000, Tags: [md_custom_spawned, md_structure_persistence_checked]}'
        lines.append("")
        if a in MOB_NEVER_BABY:
            lines.append(f"return run summon {animal_id_namespaced} {summon_pos} {nbt_adult}")
        else:
            # Baby roll: roll [0, 999] and compare against $BabySpawnChance (per-mille, 0..1000).
            lines.append("execute store result score #baby_roll md_state run random value 0..999")
            lines.append(
                f"execute if score #baby_roll md_state < $BabySpawnChance md_animal_config "
                f"run return run summon {animal_id_namespaced} {summon_pos} {nbt_baby}"
            )
            lines.append(f"return run summon {animal_id_namespaced} {summon_pos} {nbt_adult}")

        out = summon_dir / f"{variant_filename(a, mn, mx)}.mcfunction"
        out.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(f"  wrote {len(variants)} per-(animal,pack-range) summon functions "
          f"({len(animal_to_biomes)} animals)")


def write_animal_spawn_group_tags(canonical_to_members: dict[str, list[str]]) -> None:
    """Emit a biome tag per multi-biome group, listing all members. Singletons get
    no tag (they're routed by per-biome `if biome ~ ~ ~ minecraft:<biome>` instead)."""
    out_dir = (ROOT / "data" / "mob_dash" / "tags" / "worldgen"
               / "biome" / "animal_spawn_groups")
    out_dir.mkdir(parents=True, exist_ok=True)
    wipe_dir(out_dir, "*.json")
    count = 0
    for canonical, members in sorted(canonical_to_members.items()):
        if len(members) <= 1:
            continue
        out = out_dir / f"{canonical}.json"
        out.write_text(
            json.dumps({"values": [f"minecraft:{b}" for b in members]}, indent=2) + "\n",
            encoding="utf-8",
        )
        count += 1
    print(f"  wrote {count} animal spawn group tags")


def write_polar_bears_alt_biomes_tag() -> None:
    """Emit the biome tag listing biomes where polar bears can spawn on the alternate
    block tag (ice). Used by summon/polar_bear's block-under check."""
    out = (ROOT / "data" / "mob_dash" / "tags" / "worldgen"
           / "biome" / "polar_bears_alt_biomes.json")
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(
        json.dumps({"values": POLAR_BEAR_ALT_BIOMES}, indent=2) + "\n",
        encoding="utf-8",
    )
    print(f"  wrote polar_bears_alt_biomes biome tag ({len(POLAR_BEAR_ALT_BIOMES)} biomes)")


def write_no_animal_spawns_tag(no_spawn_biomes: list[str]) -> None:
    """Emit a biome tag listing overworld biomes with no native animal spawns, so
    check_position can fast-path early-exit before any block / entity scanning."""
    out = ROOT / "data" / "mob_dash" / "tags" / "worldgen" / "biome" / "no_animal_spawns.json"
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(
        json.dumps({"values": no_spawn_biomes}, indent=2) + "\n",
        encoding="utf-8",
    )
    print(f"  wrote no_animal_spawns biome tag ({len(no_spawn_biomes)} biomes)")


def write_decode_animal_name(animal_ids: dict[str, int]) -> None:
    """Maps #picked_animal_id back to a display name on Debug.AnimalName for
    spawn_print's tellraw output. Default is "None" (matches try_spawn's reset
    of #picked_animal_id to -1, and the "no animal picked" case where no summon
    fires). Auto-generated from the same ID mapping the summons write to."""
    out = (ROOT / "data" / "mob_dash" / "function" / "game" / "animals"
           / "debug" / "decode_animal_name.mcfunction")
    out.parent.mkdir(parents=True, exist_ok=True)
    lines = [
        "# Auto-generated. Decodes #picked_animal_id into Debug.AnimalName for the",
        "#  spawn-print tellraw. ID -1 (set by 'try_spawn') or any unmatched value",
        "#  falls through to the 'None' default, covering the 'no animal picked'",
        "#  case where the summon never fired",
        "# Caller: 'debug/spawn_print'",
        "",
    ]
    for a, aid in sorted(animal_ids.items(), key=lambda kv: kv[1]):
        pretty = " ".join(word.capitalize() for word in a.split("_"))
        lines.append(
            f"execute if score #picked_animal_id md_state matches {aid} "
            f'run return run data modify storage mob_dash:data Debug.AnimalName set value "{pretty}"'
        )
    lines.append("")
    lines.append('data modify storage mob_dash:data Debug.AnimalName set value "None"')
    out.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(f"  wrote debug/decode_animal_name.mcfunction ({len(animal_ids)} mappings)")


def write_pick_for_animal(
    animal_ids: dict[str, int],
    biome_to_animals: dict[str, list[tuple[str, int, int, int]]],
) -> None:
    """Pack-spawn dispatcher: given #picked_animal_id (set by the initial summon)
    and the current biome, route to a summon variant for that species. Used by
    pack/validate_and_summon on each pack attempt. The summon's sentinel guard on
    #pack_attempts prevents re-rolling, so any variant of the species works —
    we pick the alphabetically-first variant per animal for determinism."""
    out = SPAWN_DIR / "pack" / "pick_for_animal.mcfunction"
    out.parent.mkdir(parents=True, exist_ok=True)

    # Variant per animal: alphabetically first across all biomes that spawn it.
    animal_to_variants: dict[str, set[tuple[int, int]]] = defaultdict(set)
    for entries in biome_to_animals.values():
        for animal, _, mn, mx in entries:
            animal_to_variants[short(animal)].add((mn, mx))
    canonical_variant: dict[str, str] = {}
    for a, ranges in animal_to_variants.items():
        files = sorted(variant_filename(a, mn, mx) for mn, mx in ranges)
        canonical_variant[a] = files[0]

    lines = [
        "# Auto-generated. Pack-attempt dispatcher: re-runs the originally-picked",
        "#  species' summon if the current biome still allows it. Callers (pack/",
        "#  validate_and_summon) run this after a successful check_position on a",
        "#  drifted pack attempt position",
        "# Reads:",
        "#   #picked_animal_id md_state   integer animal ID set by the initial summon",
        "# Per-animal biome tags (#mob_dash:spawns/<animal>) gate by biome — if the",
        "#  drifted position is in a biome where the locked species can't spawn, the",
        "#  function falls through and returns -11 (counts as a wasted pack attempt,",
        "#  matches vanilla)",
        "",
    ]
    for a, aid in sorted(animal_ids.items(), key=lambda kv: kv[1]):
        lines.append(
            f"execute if score #picked_animal_id md_state matches {aid} "
            f"if biome ~ ~ ~ #mob_dash:spawns/{a} "
            f"run return run function mob_dash:game/animals/spawn/summon/{canonical_variant[a]}"
        )
    lines.append("")
    lines.append("return -11")
    out.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(f"  wrote pack/pick_for_animal.mcfunction ({len(animal_ids)} animal routes)")


def main() -> None:
    print("Collecting creature spawns from overworld_biomes/ "
          "(with data/minecraft/worldgen/biome/ overrides taking priority) ...")
    animal_to_biomes, biome_to_animals, no_spawn_biomes = collect_creature_spawns()
    canonical_to_members, _ = find_animal_spawn_groups(biome_to_animals)
    animal_ids = assign_animal_ids(animal_to_biomes)
    multi_member_groups = sum(1 for m in canonical_to_members.values() if len(m) > 1)
    print(f"  {len(animal_to_biomes)} animals across {len(biome_to_animals)} biomes "
          f"({len(canonical_to_members)} canonical, {multi_member_groups} multi-biome groups, "
          f"{len(no_spawn_biomes)} no-spawn biomes)")
    print()
    print("Writing generated files:")
    write_animal_tags(animal_to_biomes)
    write_no_animal_spawns_tag(no_spawn_biomes)
    write_polar_bears_alt_biomes_tag()
    write_animal_spawn_group_tags(canonical_to_members)
    write_initialize_weights(biome_to_animals, canonical_to_members)
    write_refresh_weight_sums(biome_to_animals, canonical_to_members)
    write_pick_for_biome(canonical_to_members)
    write_per_biome_functions(biome_to_animals, canonical_to_members)
    write_summon_functions(animal_to_biomes, biome_to_animals, animal_ids)
    write_pick_for_animal(animal_ids, biome_to_animals)
    write_decode_animal_name(animal_ids)


if __name__ == "__main__":
    main()
