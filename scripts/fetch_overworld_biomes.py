"""
Refreshes overworld_biomes/ by fetching vanilla biome JSONs from misode/mcmeta
(the community-maintained, version-controlled mirror of Minecraft's generated
data: https://github.com/misode/mcmeta).

Usage:
    py fetch_overworld_biomes.py              # MC version derived from pack.mcmeta
    py fetch_overworld_biomes.py --ref 26.1.2 # specific version tag (or branch name)

Behaviour:
- Reads the #minecraft:is_overworld biome tag from the chosen ref
- Downloads every overworld biome's JSON, including biomes with empty
  spawners.creature lists (deep oceans, deserts, caves, etc.). The generator
  partitions creature-bearing biomes (which become spawn routes) from
  no-creature biomes (which become the #mob_dash:no_animal_spawns tag).
  Custom biome overrides at data/minecraft/worldgen/biome/ are resolved by
  the generator.
- Wipes the folder first so renames/removals propagate cleanly

Why misode/mcmeta:
- Mojang doesn't publish data JSONs as a flat web API; they're packed inside
  the version-specific client/server jar
- misode/mcmeta extracts and version-tracks them on GitHub
- This is also the data source Misode's interactive worldgen tools use
"""
import argparse
import concurrent.futures
import json
import re
import sys
import urllib.error
import urllib.request
from pathlib import Path

from _pack_meta import resolve_target_mc_version

SCRIPT_DIR = Path(__file__).resolve().parent
ROOT = SCRIPT_DIR.parent  # datapack root (one level up from scripts/)
BIOME_DIR = SCRIPT_DIR / "overworld_biomes"

BASE = "https://raw.githubusercontent.com/misode/mcmeta/{ref}/data/minecraft"

# misode/mcmeta tags pinned versions as e.g. '26.1.2-data-json',
# 'snapshot-5-data-json', etc. If the user passes a bare version we auto-suffix.
VERSION_PATTERN = re.compile(r"^\d+(\.\d+)*(-(?:pre|rc|snapshot)-?\d*)?$")


def fetch(url: str) -> bytes:
    try:
        with urllib.request.urlopen(url, timeout=15) as resp:
            return resp.read()
    except urllib.error.HTTPError as e:
        sys.exit(f"HTTP {e.code} fetching {url}")
    except urllib.error.URLError as e:
        sys.exit(f"Network error fetching {url}: {e.reason}")


def fetch_json(url: str) -> dict:
    return json.loads(fetch(url).decode("utf-8"))


def list_overworld_biomes(ref: str) -> list[str]:
    """Return short biome names (without 'minecraft:') from #minecraft:is_overworld."""
    tag_url = f"{BASE.format(ref=ref)}/tags/worldgen/biome/is_overworld.json"
    tag = fetch_json(tag_url)
    biomes = []
    for value in tag.get("values", []):
        if isinstance(value, dict):  # entry can be {"id":..., "required":false}
            value = value["id"]
        if value.startswith("#"):
            sys.exit(f"is_overworld tag references nested tag {value}; "
                     "extraction needs recursive resolution. Open a PR.")
        biomes.append(value.removeprefix("minecraft:"))
    return sorted(biomes)


def fetch_biome(ref: str, biome: str) -> bytes:
    return fetch(f"{BASE.format(ref=ref)}/worldgen/biome/{biome}.json")


def parse_args() -> argparse.Namespace:
    p = argparse.ArgumentParser(description=__doc__.split("\n\n")[0])
    p.add_argument("--ref", default=None,
                   help="misode/mcmeta git ref (branch or tag). "
                        "Defaults to the MC version that matches pack.mcmeta's max_format. "
                        "Pass a version tag like '26.1.2' or a branch like 'data-json' to override.")
    return p.parse_args()


def resolve_ref(ref: str) -> str:
    """If `ref` looks like a bare version (e.g., '26.1.2'), append '-data-json'
    to match misode/mcmeta's tag naming."""
    if VERSION_PATTERN.match(ref) and not ref.endswith("-data-json"):
        return f"{ref}-data-json"
    return ref


def main() -> None:
    args = parse_args()
    if args.ref is None:
        args.ref = resolve_target_mc_version(ROOT)
    ref = resolve_ref(args.ref)

    # Resolve and report the version we're fetching
    try:
        version = fetch_json(f"https://raw.githubusercontent.com/misode/mcmeta/{ref}/version.json")
        version_label = f"{version.get('id', '?')} (ref: {ref})"
    except SystemExit:
        version_label = f"(ref: {ref})"

    print(f"Fetching biome data from misode/mcmeta {version_label}...")

    biomes = list_overworld_biomes(ref)
    print(f"  is_overworld -> {len(biomes)} biomes")

    BIOME_DIR.mkdir(parents=True, exist_ok=True)
    for stale in BIOME_DIR.glob("*.json"):
        stale.unlink()

    def download(biome: str) -> str:
        raw = fetch_biome(ref, biome)
        # Normalize to CRLF to match the project's working-tree line-ending convention.
        raw = raw.replace(b"\r\n", b"\n").replace(b"\r", b"\n").replace(b"\n", b"\r\n")
        (BIOME_DIR / f"{biome}.json").write_bytes(raw)
        return biome

    with concurrent.futures.ThreadPoolExecutor(max_workers=8) as ex:
        results = sorted(ex.map(download, biomes))

    for b in results:
        print(f"  fetched {b}")

    print(f"\nWrote {len(results)} biome JSONs to {BIOME_DIR.relative_to(ROOT)} "
          f"(custom overrides in data/minecraft/worldgen/biome/ take priority "
          f"in the generator)")


if __name__ == "__main__":
    main()
