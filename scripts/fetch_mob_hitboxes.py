"""
Refreshes mob_hitboxes.json by scraping adult hitbox dimensions from minecraft.wiki.
Run this when bumping the datapack to a new MC release; the data is hand-maintained
by the wiki community and rarely changes between releases.

Usage:
    py fetch_mob_hitboxes.py

Behaviour:
- Reads the mob list from overworld_animal_biomes/ (so this stays in sync with
  whatever the spawn system actually uses; refresh that folder first via
  fetch_overworld_animal_biomes.py)
- Resolves the target MC version from pack.mcmeta's max_format and prints it
  (the wiki API itself returns current data; the version is informational so
  you can verify the wiki page hasn't drifted ahead of your target release)
- Fetches each mob's wiki page via the MediaWiki API, parses the `size` infobox
  parameter, extracts the adult Height/Width
- Diffs against the existing mob_hitboxes.json and prints additions, changes, and
  removals — review them before regenerating to catch any wiki errors

Why minecraft.wiki:
- Mojang publishes no entity-dimension data; the values are baked into Java source
- minecraft.wiki transcribes them within hours of a release; PrismarineJS lags weeks
- Trade-off: wikitext is freeform, so this parser is best-effort. If a page changes
  format and parsing fails it'll exit with a clear error — fix WIKI_PAGE_OVERRIDES
  or the regexes and re-run.
"""
import json
import re
import sys
import urllib.error
import urllib.parse
import urllib.request
from pathlib import Path

from _pack_meta import resolve_target_mc_version

SCRIPT_DIR = Path(__file__).resolve().parent
ROOT = SCRIPT_DIR.parent  # datapack root (one level up from scripts/)
BIOME_DIR = SCRIPT_DIR / "overworld_animal_biomes"
OUT_FILE = SCRIPT_DIR / "mob_hitboxes.json"

WIKI_API = "https://minecraft.wiki/api.php"
USER_AGENT = "MobDash-tooling/1.0 (datapack tooling; https://github.com/HunsingerTheMatist/MobDash)"

# Override the default page name (mob.replace("_", " ").title()) when the wiki uses a
# different canonical title. Empty for now — verified against MC 26.1; add entries here
# if a future release introduces a mob whose wiki title doesn't match the convention.
WIKI_PAGE_OVERRIDES: dict[str, str] = {}


def collect_mob_ids() -> list[str]:
    """Read overworld_animal_biomes/ and return short mob ids (no namespace)."""
    if not BIOME_DIR.is_dir():
        sys.exit(f"{BIOME_DIR.relative_to(ROOT)}/ not found. "
                 f"Run fetch_overworld_animal_biomes.py first.")
    mobs: set[str] = set()
    for path in sorted(BIOME_DIR.glob("*.json")):
        data = json.loads(path.read_text(encoding="utf-8"))
        for entry in data.get("spawners", {}).get("creature", []):
            mobs.add(entry["type"].removeprefix("minecraft:"))
    return sorted(mobs)


def wiki_page_name(mob: str) -> str:
    return WIKI_PAGE_OVERRIDES.get(mob, mob.replace("_", " ").title())


def fetch_wikitext(page: str) -> str:
    params = {
        "action": "parse",
        "page": page,
        "prop": "wikitext",
        "redirects": "1",
        "format": "json",
        "formatversion": "2",
    }
    url = f"{WIKI_API}?{urllib.parse.urlencode(params)}"
    req = urllib.request.Request(url, headers={"User-Agent": USER_AGENT})
    try:
        with urllib.request.urlopen(req, timeout=15) as resp:
            data = json.loads(resp.read().decode("utf-8"))
    except urllib.error.HTTPError as e:
        sys.exit(f"HTTP {e.code} fetching wiki page '{page}': {e.reason}")
    except urllib.error.URLError as e:
        sys.exit(f"Network error fetching wiki page '{page}': {e.reason}")
    if "error" in data:
        sys.exit(f"Wiki API error for '{page}': {data['error'].get('info', data['error'])}")
    return data["parse"]["wikitext"]


# Match `| size = ...` up to the next infobox parameter (`| key =`) or end of template (`}}`).
SIZE_FIELD_RE = re.compile(
    r"^\s*\|\s*size\s*=\s*(?P<body>.*?)(?=^\s*\|\s*\w+\s*=|^\s*\}\}\s*$)",
    re.MULTILINE | re.DOTALL,
)
# Inside the size body, find the Adult subsection (up to the next bold marker).
# Some pages omit Adult/Baby labels entirely — fall back to the whole body.
ADULT_SECTION_RE = re.compile(r"'''\s*Adult\s*:?\s*'''\s*(.*?)(?='''|\Z)", re.DOTALL)
HEIGHT_RE = re.compile(r"Height\s*:\s*([\d.]+)\s*blocks?", re.IGNORECASE)
WIDTH_RE = re.compile(r"Width\s*:\s*([\d.]+)\s*blocks?", re.IGNORECASE)


def parse_adult_hitbox(wikitext: str) -> tuple[float, float]:
    m = SIZE_FIELD_RE.search(wikitext)
    if not m:
        raise ValueError("no `| size = ...` parameter in infobox")
    size_text = m.group("body")
    section_match = ADULT_SECTION_RE.search(size_text)
    section = section_match.group(1) if section_match else size_text
    h_match = HEIGHT_RE.search(section)
    w_match = WIDTH_RE.search(section)
    if not h_match or not w_match:
        raise ValueError(f"no Height/Width in adult section: {section[:200]!r}")
    return float(w_match.group(1)), float(h_match.group(1))


def diff_hitboxes(
    old: dict, new: dict
) -> tuple[list[str], list[tuple[str, dict, dict]], list[str]]:
    old_keys, new_keys = set(old), set(new)
    added = sorted(new_keys - old_keys)
    removed = sorted(old_keys - new_keys)
    changed = [(k, old[k], new[k]) for k in sorted(new_keys & old_keys) if old[k] != new[k]]
    return added, changed, removed


def fmt(entry: dict) -> str:
    return f"{entry['width']}w x {entry['height']}h"


def main() -> None:
    target_version = resolve_target_mc_version(ROOT)
    mobs = collect_mob_ids()
    print(f"Fetching adult hitboxes for {len(mobs)} mobs from minecraft.wiki "
          f"(targeting MC {target_version}; the wiki API returns current data, "
          f"so manually verify if a recent MC update changed any hitboxes)...")

    new_data: dict[str, dict[str, float]] = {}
    for mob in mobs:
        page = wiki_page_name(mob)
        try:
            wikitext = fetch_wikitext(page)
            width, height = parse_adult_hitbox(wikitext)
        except ValueError as e:
            sys.exit(f"  parse failed for {mob} (page '{page}'): {e}\n"
                     f"  if the wiki uses a different page title, "
                     f"add an entry to WIKI_PAGE_OVERRIDES.")
        new_data[mob] = {"width": width, "height": height}
        print(f"  {mob:<12} -> {width} x {height}  (page: {page})")

    if OUT_FILE.exists():
        old_data = json.loads(OUT_FILE.read_text(encoding="utf-8"))
    else:
        old_data = {}
    added, changed, removed = diff_hitboxes(old_data, new_data)

    OUT_FILE.write_text(
        json.dumps(new_data, indent=2, sort_keys=True) + "\n",
        encoding="utf-8",
    )

    print(f"\nWrote {OUT_FILE.relative_to(ROOT)} ({len(new_data)} mobs)")
    if not (added or changed or removed):
        print("  no changes vs. previous run")
        return
    for m in added:
        print(f"  added   {m:<12} {fmt(new_data[m])}")
    for m, old_e, new_e in changed:
        print(f"  changed {m:<12} {fmt(old_e)}  ->  {fmt(new_e)}")
    for m in removed:
        print(f"  removed {m:<12} (was {fmt(old_data[m])})")


if __name__ == "__main__":
    main()
