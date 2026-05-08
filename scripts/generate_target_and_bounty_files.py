"""
Generates target and bounty marker creation, kill advancements, and per-mob kill-
detection mcfunctions from targets_and_bounties.json. Also writes tiers.md as a
player-facing reference for which mobs are in which tier.

Usage:
    py generate_target_and_bounty_files.py

Inputs:
    targets_and_bounties.json
        Tier and bounty definitions (hand-edited).

Outputs (auto-overwritten on every run):
    data/mob_dash/function/load/create_targets.mcfunction
    data/mob_dash/function/load/create_bounties.mcfunction
    data/mob_dash/advancement/kill_<name>.json (per target & bounty)
    data/mob_dash/function/game/kill_detection/killed_<name>.mcfunction (per target & bounty)
    tiers.md
"""
import json
import os
from dataclasses import dataclass
from pathlib import Path
from typing import Optional

# Run all relative-path I/O against the datapack root, regardless of cwd.
SCRIPT_DIR = Path(__file__).resolve().parent
os.chdir(SCRIPT_DIR.parent)

CONFIG_FILE = SCRIPT_DIR / "targets_and_bounties.json"


@dataclass
class MobInfo:
    name: str
    weight: int
    hostile: bool = False
    night: bool = False
    nether: bool = False


@dataclass
class BountyInfo(MobInfo):
    min_score: Optional[int] = None
    max_score: Optional[int] = None
    id_override: Optional[str] = None
    jockey: Optional[str] = None
    conditions: Optional[dict] = None


config = json.loads(CONFIG_FILE.read_text(encoding="utf-8"))
all_mobs: dict[int, list[MobInfo]] = {
    int(level): [MobInfo(**entry) for entry in mob_list]
    for level, mob_list in config["tiers"].items()
}
bounties: list[BountyInfo] = [BountyInfo(**entry) for entry in config["bounties"]]


def get_display_name(mob: str) -> str:
    return mob.replace('_', ' ').title()


def get_marker_tag(name: str) -> str:
    return f"md_{name}"


def get_level(mob_info):
    for level, mobs in all_mobs.items():
        if mob_info in mobs:
            return level
    return 0


def get_scoreboard_name(mob: str) -> str:
    return f"md_{mob[:12]}"


with open('data/mob_dash/function/load/create_targets.mcfunction', 'w') as file:
    file.write('# Create target markers (auto-generated file)\n')

    prev_lvl = None
    max_name_len = max(len(mob.name) for mobs in all_mobs.values() for mob in mobs)
    for level, mobs in all_mobs.items():
        for mob in mobs:
            display_name = get_display_name(mob.name)
            pad_len = max_name_len - len(display_name)

            extra_tags = []
            if mob.hostile:
                extra_tags.append("md_hostile")
            if mob.night:
                extra_tags.append("md_night")
            if mob.nether:
                extra_tags.append("md_nether")

            tag_str = ", ".join(["md_target", *extra_tags, get_marker_tag(mob.name)])

            if level != prev_lvl:
                file.write("\n")

            file.write(
                f'summon marker ~ ~ ~ {{CustomName:"{display_name}", {" " * pad_len}'
                f'data: {{level: {level}, weight: {mob.weight}}}, '
                f'Tags:[{tag_str}]}}\n'
            )

            prev_lvl = level

    file.write('\nexecute as @e[distance=..1,type=marker,tag=md_target] store result score @s md_level run data get entity @s data.level')
    file.write('\nexecute as @e[distance=..1,type=marker,tag=md_target] store result score @s md_weight run data get entity @s data.weight\n')

with open('data/mob_dash/function/load/create_bounties.mcfunction', 'w') as file:
    file.write('# Create bounty markers (auto-generated file)\n\n')

    max_name_len = max(len(b.name) for b in bounties)
    for bounty in bounties:
        display_name = get_display_name(bounty.name)
        pad_len = max_name_len - len(display_name)

        extra_tags = []
        if bounty.hostile:
            extra_tags.append("md_hostile")
        if bounty.night:
            extra_tags.append("md_night")
        if bounty.nether:
            extra_tags.append("md_nether")

        tag_str = ", ".join(["md_bounty", *extra_tags, get_marker_tag(bounty.name)])

        file.write(
            f'summon marker ~ ~ ~ {{CustomName:"{display_name}", {" " * pad_len}'
            f'data: {{weight: {bounty.weight}, min_score: {bounty.min_score}, max_score: {bounty.max_score}}}, '
            f'Tags:[{tag_str}]}}\n'
        )

    # Store data fields into scoreboards
    file.write('\nexecute as @e[distance=..1,type=marker,tag=md_bounty] store result score @s md_weight run data get entity @s data.weight')
    file.write('\nexecute as @e[distance=..1,type=marker,tag=md_bounty] store result score @s md_min_score run data get entity @s data.min_score')
    file.write('\nexecute as @e[distance=..1,type=marker,tag=md_bounty] store result score @s md_max_score run data get entity @s data.max_score\n')


def add_entity_namespace(name: str) -> str:
    """Return the correct namespaced entity string for JSON"""
    if name.startswith("#"):
        return f"#minecraft:{name[1:]}"  # tag
    return f"minecraft:{name}"  # normal entity


def get_normal_kill_json(name: str, id_override: str=None) -> dict:
    """Write the kill advancement JSON for a normal mob"""
    advancement_json = {
        "criteria": {
            "requirement": {
                "trigger": "minecraft:player_killed_entity",
                "conditions": {"entity": {"type": f"{add_entity_namespace(id_override or name)}"}}
            }
        },
        "rewards": {"function": f"mob_dash:game/kill_detection/killed_{name}"}
    }
    return advancement_json


def get_jockey_kill_json(name: str, jockey: str) -> dict:
    """Write the kill advancement JSON for a jockey-type bounty.
    Awards the kill whenever any mob is killed that participates in a passenger/vehicle
    relationship with the given jockey type, regardless of the other party's type."""
    jockey_ns = add_entity_namespace(jockey)
    criteria = {
        f"kill_{jockey}_carrying_entity": {
            "trigger": "minecraft:player_killed_entity",
            "conditions": {"entity": {"type": jockey_ns, "passenger": {}}}
        },
        f"kill_entity_riding_{jockey}": {
            "trigger": "minecraft:player_killed_entity",
            "conditions": {"entity": {"vehicle": {"type": jockey_ns}}}
        },
    }
    return {
        "criteria": criteria,
        "requirements": [list(criteria.keys())],
        "rewards": {"function": f"mob_dash:game/kill_detection/killed_{name}"}
    }


for mobs in all_mobs.values():
    for mob in mobs:
        name = mob.name
        display_name = get_display_name(name)

        with open(f"data/mob_dash/advancement/kill_{name}.json", "w") as f:
            json.dump(get_normal_kill_json(name), f, indent=2)
            f.write("\n")

        with open(f"data/mob_dash/function/game/kill_detection/killed_{name}.mcfunction", "w") as f:
            f.write('# Runs when the current mob has been killed (auto-generated file)\n\n')
            f.write(f'advancement revoke @s only mob_dash:kill_{name}\n')
            f.write('tag @s add md_current\n')
            f.write(
                f'execute in mob_dash:md_markers positioned 0 0 0 '
                f'as @n[distance=..1,type=marker,tag=md_target,tag=md_selected,tag={get_marker_tag(name)}] '
                f'run function mob_dash:game/award_kill\n'
            )
            f.write('tag @s remove md_current\n')

for bounty in bounties:
    name = bounty.name
    display_name = get_display_name(name)

    if bounty.jockey is None:
        advancement_json = get_normal_kill_json(name, bounty.id_override)

        # Inject special conditions if present
        if bounty.conditions:
            advancement_json["criteria"]["requirement"]["conditions"]["entity"].update(bounty.conditions)
    else:
        advancement_json = get_jockey_kill_json(name, bounty.jockey)

    with open(f"data/mob_dash/advancement/kill_{name}.json", "w") as f:
        json.dump(advancement_json, f, indent=2)
        f.write("\n")

    with open(f"data/mob_dash/function/game/kill_detection/killed_{name}.mcfunction", "w") as f:
        f.write('# Runs when the current bounty has been killed (auto-generated file)\n\n')
        f.write(f'advancement revoke @s only mob_dash:kill_{name}\n')
        f.write('tag @s add md_current\n')
        f.write(
            f'execute in mob_dash:md_markers positioned 0 0 0 '
            f'as @n[distance=..1,type=marker,tag=md_bounty,tag=md_selected,tag={get_marker_tag(name)}] '
            f'run function mob_dash:game/bounty/award_kill\n'
        )
        f.write('tag @s remove md_current\n')

with open("tiers.md", "w") as file:
    # Write regular mob tiers
    for level in sorted(all_mobs.keys()):
        file.write(f"### Tier {level}\n")
        for mob in sorted(all_mobs[level], key=lambda m: m.name):
            file.write(f"- {get_display_name(mob.name)}\n")
        file.write("\n")

    # Write Bounty section
    file.write("### Bounties\n")
    for bounty in sorted(bounties, key=lambda b: b.name):
        file.write(f"- {get_display_name(bounty.name)}\n")
    file.write("\n")