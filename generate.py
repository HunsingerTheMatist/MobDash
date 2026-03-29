import json
from dataclasses import dataclass
from typing import List, Dict, Optional

@dataclass
class MobInfo:
    name: str
    weight: int
    hostile: bool = False
    night: bool = False
    nether: bool = False

level_1_mobs = [
    MobInfo("bee",     weight=3),
    MobInfo("chicken", weight=5),
    MobInfo("cod",     weight=5),
    MobInfo("cow",     weight=5),
    MobInfo("dolphin", weight=4),
    MobInfo("horse",   weight=3),
    MobInfo("pig",     weight=5),
    MobInfo("rabbit",  weight=1),
    MobInfo("salmon",  weight=5),
    MobInfo("sheep",   weight=5),
    MobInfo("squid",   weight=5),
    MobInfo("turtle",  weight=3),
]

level_2_mobs = [
    MobInfo("bat",      weight=2),
    MobInfo("creeper",  weight=5, hostile=True, night=True),
    MobInfo("drowned",  weight=5, hostile=True, night=True),
    MobInfo("skeleton", weight=5, hostile=True, night=True),
    MobInfo("spider",   weight=5, hostile=True, night=True),
    MobInfo("zombie",   weight=5, hostile=True, night=True),
]

level_3_mobs = [
    MobInfo("armadillo",        weight=1),
    MobInfo("axolotl",          weight=2),
    MobInfo("copper_golem",     weight=3),
    MobInfo("nautilus",         weight=1),
    MobInfo("fox",              weight=2),
    MobInfo("frog",             weight=1),
    MobInfo("glow_squid",       weight=2),
    MobInfo("goat",             weight=1),
    MobInfo("iron_golem",       weight=3),
    MobInfo("llama",            weight=1),
    MobInfo("polar_bear",       weight=2),
    MobInfo("snow_golem",       weight=3),
    MobInfo("tropical_fish",    weight=1),
    MobInfo("wolf",             weight=2),
    MobInfo("enderman",         weight=4, hostile=True, night=True),
    MobInfo("witch",            weight=2, hostile=True, night=True),
    MobInfo("strider",          weight=5, nether=True),
    MobInfo("ghast",            weight=4, hostile=True, nether=True),
    MobInfo("hoglin",           weight=5, hostile=True, nether=True),
    MobInfo("magma_cube",       weight=3, hostile=True, nether=True),
    MobInfo("piglin",           weight=5, hostile=True, nether=True),
    MobInfo("zombified_piglin", weight=5, hostile=True, nether=True),
]

level_4_mobs = [
    MobInfo("blaze",           weight=3, hostile=True, nether=True),
    MobInfo("piglin_brute",    weight=2, hostile=True, nether=True),
    MobInfo("wither_skeleton", weight=3, hostile=True, nether=True),
]

all_mobs = {
    1: level_1_mobs,
    2: level_2_mobs,
    3: level_3_mobs,
    4: level_4_mobs,
}

@dataclass
class JockeyInfo:
    vehicle: str
    passengers: List[str]

@dataclass
class BountyInfo(MobInfo):
    min_score: int = None
    max_score: int = None
    id_override: str = None
    jockey: Optional[JockeyInfo] = None
    conditions: Optional[Dict] = None

bounties = [
    BountyInfo("mooshroom",              weight=2, min_score=10, max_score=15),
    BountyInfo("panda",                  weight=1, min_score=10, max_score=14),
    BountyInfo("warden",                 weight=4, min_score=20, max_score=30, hostile=True),
    BountyInfo("creaking",               weight=2, min_score=17, max_score=22, hostile=True, night=True),
    BountyInfo("zoglin",                 weight=4, min_score=17, max_score=20, hostile=True, nether=True),
    BountyInfo("camel_husk_jockey",      weight=1, min_score=18, max_score=24, hostile=True, night=True, jockey=JockeyInfo(vehicle="camel_husk", passengers=["husk","parched"])),
    BountyInfo("chicken_jockey",         weight=5, min_score=12, max_score=17, hostile=True, night=True, jockey=JockeyInfo(vehicle="chicken", passengers=["#zombies"])),
    BountyInfo("spider_jockey",          weight=4, min_score=14, max_score=18, hostile=True, night=True, jockey=JockeyInfo(vehicle="spider", passengers=["#skeletons"])),
    BountyInfo("zombie_horseman",        weight=3, min_score=13, max_score=17, hostile=True, night=True, jockey=JockeyInfo(vehicle="zombie_horse", passengers=["#zombies"])),
    BountyInfo("zombie_nautilus_jockey", weight=2, min_score=18, max_score=25, hostile=True, night=True, jockey=JockeyInfo(vehicle="zombie_nautilus", passengers=["#zombies"])),
    BountyInfo("invisible_spider",       weight=2, min_score=15, max_score=20, hostile=True, night=True, id_override="spider", conditions={"effects": {"minecraft:invisibility": {}}}),
    BountyInfo("strider_jockey",         weight=4, min_score=10, max_score=12, nether=True, jockey=JockeyInfo(vehicle="strider", passengers=["strider","zombified_piglin"])),
]

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

#def pad_tag_lines(tag_lines: list[str]) -> list[str]:
#    max_line_len = max(len(s) for s in tag_lines)
#    return [s.replace("*",' '*(max_line_len - len(s))) for s in tag_lines]

#with open('data/mob_dash/function/load/create_target_scoreboards.mcfunction', 'w') as file:
#    file.write('# Create all target scoreboards (auto-generated file)\n\n')
#
#    for mob, *_ in all_mobs:
#        display_name = get_display_name(mob)
#        scoreboard_name = get_scoreboard_name(mob)
#        file.write(f'scoreboard objectives add {scoreboard_name} minecraft.killed:minecraft.{mob} "Mob Dash {display_name} Kills"\n')

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
    file.write('\nexecute as @e[distance=..1,type=marker,tag=md_target] store result score @s md_weight run data get entity @s data.weight')

#with open('data/mob_dash/function/load/update_targets.mcfunction', 'w') as file:
#    file.write('# Update target markers (auto-generated file)\n\n')
#
#    create_lines = []
#    data_lines = []
#    hostile_lines = []
#    night_lines = []
#    nether_lines = []
#    valid_lines = []
#
#    max_name_lens = [max(len(mob.name) for mob in mobs) for mobs in all_mobs.values()]    
#    prev_level = None
#    for level, mobs in all_mobs.items():
#        for mob in mobs:
#            name = mob.name
#            display_name = get_display_name(name)
#            tag = get_marker_tag(name)
#            pad_len = max_name_lens[level - 1] - len(name)
#
#            if level != prev_level:
#                create_lines.append(f'# Level {level}')
#                data_lines.append(f'# Level {level}')
#                valid_lines.append(f'# Level {level}')
#                prev_level = level
#
#            # Spawn target if missing
#            create_lines.append(
#                f'execute unless entity @n[distance=..1,type=marker,tag=md_target,tag={tag}{" "*pad_len}] '
#                f'run summon marker ~ ~ ~ {{Tags:[md_target, {tag}]}}'
#            )
#
#            # Update target data
#            data_lines.append(
#                f'data merge entity @n[distance=..1,type=marker,tag=md_target,tag={tag}{" "*pad_len}] '
#                f'{{CustomName:"{display_name}", {" "*pad_len}data: {{level: {level}, weight: {mob.weight}}}}}'
#            )
#
#            # Add additional tags
#            if mob.hostile:
#                hostile_lines.append(f'tag @n[distance=..1,type=marker,tag=md_target,tag={tag}*] add md_hostile')
#
#            if mob.night:
#                night_lines.append(f'tag @n[distance=..1,type=marker,tag=md_target,tag={tag}*] add md_night')
#
#            if mob.nether:
#                nether_lines.append(f'tag @n[distance=..1,type=marker,tag=md_target,tag={tag}*] add md_nether')
#
#            # Mark valid markers
#            valid_lines.append(f'tag @n[distance=..1,type=marker,tag=md_target,tag={tag}{" "*pad_len}] add md_valid')
#
#    file.write('## Remove additional tags\n')
#    file.write('tag @e[type=marker,tag=md_target] remove md_hostile\n')
#    file.write('tag @e[type=marker,tag=md_target] remove md_night\n')
#    file.write('tag @e[type=marker,tag=md_target] remove md_nether\n')
#    file.write('tag @e[type=marker,tag=md_target] remove md_valid\n\n')
#
#    # Write generated sections
#    file.write('## Create missing targets\n')
#    file.write("\n".join(create_lines) + "\n\n")
#
#    file.write('## Update target data\n')
#    file.write("\n".join(data_lines) + "\n\n")
#
#    file.write('## Add additional tags\n')
#    if len(hostile_lines) > 0:
#        file.write('# Hostile targets\n')
#        file.write("\n".join(pad_tag_lines(hostile_lines)) + "\n")
#    if len(night_lines) > 0:
#        file.write('# Night targets\n')
#        file.write("\n".join(pad_tag_lines(night_lines)) + "\n")
#    if len(nether_lines) > 0:
#        file.write('# Nether targets\n')
#        file.write("\n".join(pad_tag_lines(nether_lines)) + "\n")
#
#    file.write('\n## Mark valid targets\n')
#    file.write("\n".join(valid_lines) + "\n\n")
#
#    file.write('## Remove obsolete targets\n')
#    file.write('kill @e[type=marker,tag=md_target,tag=!md_valid]\n\n')
#
#    file.write('## Store scoreboard values\n')
#    file.write('execute as @e[type=marker,tag=md_target] store result score @s md_level run data get entity @s data.level\n')
#    file.write('execute as @e[type=marker,tag=md_target] store result score @s md_weight run data get entity @s data.weight\n')

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
    file.write('\nexecute as @e[distance=..1,type=marker,tag=md_bounty] store result score @s md_max_score run data get entity @s data.max_score')

#with open('data/mob_dash/function/load/update_bounties.mcfunction', 'w') as file:
#    file.write('# Update bounty markers (auto-generated file)\n\n')
#
#    create_lines = []
#    data_lines = []
#    hostile_lines = []
#    night_lines = []
#    nether_lines = []
#    valid_lines = []
#
#    max_name_len = max(len(b.name) for b in bounties)
#    for bounty in bounties:
#        name = bounty.name
#        display_name = get_display_name(name)
#        tag = get_marker_tag(name)
#        pad_len = max_name_len - len(display_name)
#
#        # Spawn bounty if missing
#        create_lines.append(
#            f'execute unless entity @n[distance=..1,type=marker,tag=md_bounty,tag={tag}{" "*pad_len}] '
#            f'run summon marker ~ ~ ~ {{Tags:[md_bounty, {tag}]}}'
#        )
#
#        # Update bounty data
#        data_lines.append(
#            f'data merge entity @n[distance=..1,type=marker,tag=md_bounty,tag={tag}{" "*pad_len}] '
#            f'{{CustomName:"{display_name}", {" "*pad_len}data: {{weight: {bounty.weight}, min_score: {bounty.min_score}, max_score: {bounty.max_score}}}}}'
#        )
#
#        # Add additional tags
#        if bounty.hostile:
#            hostile_lines.append(f'tag @n[distance=..1,type=marker,tag=md_bounty,tag={tag}*] add md_hostile')
#
#        if bounty.night:
#            night_lines.append(f'tag @n[distance=..1,type=marker,tag=md_bounty,tag={tag}*] add md_night')
#
#        if bounty.nether:
#            nether_lines.append(f'tag @n[distance=..1,type=marker,tag=md_bounty,tag={tag}*] add md_nether')
#
#        # Mark valid markers
#        valid_lines.append(f'tag @n[distance=..1,type=marker,tag=md_bounty,tag={tag}{" "*pad_len}] add md_valid')
#
#    file.write('## Remove additional tags\n')
#    file.write('tag @e[type=marker,tag=md_bounty] remove md_hostile\n')
#    file.write('tag @e[type=marker,tag=md_bounty] remove md_night\n')
#    file.write('tag @e[type=marker,tag=md_bounty] remove md_nether\n')
#    file.write('tag @e[type=marker,tag=md_bounty] remove md_valid\n\n')
#
#    # Write generated sections
#    file.write('## Create missing bounties\n')
#    file.write("\n".join(create_lines) + "\n\n")
#
#    file.write('## Update bounty data\n')
#    file.write("\n".join(data_lines) + "\n\n")
#
#    file.write('## Add additional tags\n')
#    if len(hostile_lines) > 0:
#        file.write('# Hostile bounties\n')
#        file.write("\n".join(pad_tag_lines(hostile_lines)) + "\n")
#    if len(night_lines) > 0:
#        file.write('# Night bounties\n')
#        file.write("\n".join(pad_tag_lines(night_lines)) + "\n")
#    if len(nether_lines) > 0:
#        file.write('# Nether bounties\n')
#        file.write("\n".join(pad_tag_lines(nether_lines)) + "\n")
#
#    file.write('\n## Mark valid bounties\n')
#    file.write("\n".join(valid_lines) + "\n\n")
#
#    file.write('## Remove obsolete bounties\n')
#    file.write('kill @e[type=marker,tag=md_bounty,tag=!md_valid]\n\n')
#
#    file.write('## Store scoreboard values\n')
#    file.write('execute as @e[distance=..1,type=marker,tag=md_bounty] store result score @s md_weight run data get entity @s data.weight\n')
#    file.write('execute as @e[distance=..1,type=marker,tag=md_bounty] store result score @s md_min_score run data get entity @s data.min_score\n')
#    file.write('execute as @e[distance=..1,type=marker,tag=md_bounty] store result score @s md_max_score run data get entity @s data.max_score\n')

def add_entity_namespace(name: str) -> str:
    """Return the correct namespaced entity string for JSON"""
    if name.startswith("#"):
        return f"#minecraft:{name[1:]}"  # tag
    return f"minecraft:{name}"  # normal entity

def get_normal_kill_json(name: str, id_override: str=None) -> json:
    """Write the kill advancement JSON for a normal mob"""
    advancement_json = {
        #"_autogenerated": True,
        "criteria": {
            "requirement": {
                "trigger": "minecraft:player_killed_entity",
                "conditions": {"entity": {"type": f"{add_entity_namespace(id_override or name)}"}}
            }
        },
        "rewards": {"function": f"mob_dash:game/kill_detection/killed_{name}"}
    }
    return advancement_json

for mobs in all_mobs.values():
    for mob in mobs:
        name = mob.name
        display_name = get_display_name(name)

        with open(f"data/mob_dash/advancement/kill_{name}.json", "w") as f:
            json.dump(get_normal_kill_json(name), f, indent=2)

        with open(f"data/mob_dash/function/game/kill_detection/killed_{name}.mcfunction", "w") as f:
            f.write('# Runs when the current mob has been killed (auto-generated file)\n\n')
            f.write(f'advancement revoke @s only mob_dash:kill_{name}\n')
            f.write('tag @s add md_current\n')
            f.write(
                f'execute in mob_dash:mb_markers positioned 0 0 0 '
                f'as @n[distance=..1,type=marker,tag=md_target,tag=md_selected,tag={get_marker_tag(name)}] '
                f'run function mob_dash:game/award_kill\n'
            )
            f.write('tag @s remove md_current')

for bounty in bounties:
    name = bounty.name
    display_name = get_display_name(name)

    if bounty.jockey is None:
        advancement_json = get_normal_kill_json(name, bounty.id_override)

        # Inject special conditions if present
        if bounty.conditions:
            advancement_json["criteria"]["requirement"]["conditions"]["entity"].update(bounty.conditions)

        with open(f"data/mob_dash/advancement/kill_{name}.json", "w") as f:
            json.dump(advancement_json, f, indent=2)
    else:
        # Jockey bounty: generate custom JSON
        vehicle = add_entity_namespace(bounty.jockey.vehicle)
        passengers = [add_entity_namespace(p) for p in bounty.jockey.passengers]

        multiple = len(passengers) > 1
        vehicles_dict = {}
        passengers_dict = {}
        for idx, passenger in enumerate(passengers, start=1):
            suffix = str(idx) if multiple else ""
            vehicle_key = f"kill_vehicle{suffix}"
            passenger_key = f"kill_passenger{suffix}"

            vehicles_dict[vehicle_key] = {
                "trigger": "minecraft:player_killed_entity",
                "conditions": {"entity": {"type": vehicle, "passenger": {"type": passenger}}}
            }
            passengers_dict[passenger_key] = {
                "trigger": "minecraft:player_killed_entity",
                "conditions": {"entity": {"type": passenger, "vehicle": {"type": vehicle}}}
            }

        advancement_json = {
            #"_autogenerated": True,
            "criteria": {**vehicles_dict, **passengers_dict},
            "requirements": [list(vehicles_dict.keys()) + list(passengers_dict.keys())],
            "rewards": {"function": f"mob_dash:game/kill_detection/killed_{name}"}
        }

        # Write jockey advancement JSON
        with open(f"data/mob_dash/advancement/kill_{name}.json", "w") as f:
            json.dump(advancement_json, f, indent=2)

    with open(f"data/mob_dash/function/game/kill_detection/killed_{name}.mcfunction", "w") as f:
            f.write('# Runs when the current bounty has been killed (auto-generated file)\n\n')
            f.write(f'advancement revoke @s only mob_dash:kill_{name}\n')
            f.write('tag @s add md_current\n')
            f.write(
                f'execute in mob_dash:mb_markers positioned 0 0 0 '
                f'as @n[distance=..1,type=marker,tag=md_bounty,tag=md_selected,tag={get_marker_tag(name)}] '
                f'run function mob_dash:game/bounty/award_kill\n'
            )
            f.write('tag @s remove md_current')

#with open('data/mob_dash/function/game/detect_kill.mcfunction', 'w') as file:
#    file.write('# Detect if a target has been killed (auto-generated file)\n\n')
#
#    prev_lvl = i = 1
#    for mob_info in all_mobs:
#        mob = mob_info[0]
#        level = get_level(mob_info)
#        display_name = get_display_name(mob)
#        scoreboard_name = get_scoreboard_name(mob)
#
#        if level != prev_lvl:
#            file.write("\n")
#        file.write(f'execute as @n[type=minecraft:marker,tag=md_selected,name="{display_name}"] at @p[scores={{{scoreboard_name}=1..}}] run function mob_dash:game/award_kill\n')
#        file.write(f'scoreboard players reset * {scoreboard_name}\n')
#        prev_lvl = level
#        i += 1

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

# md_mob_level: stores the level
# md_mob_weight: stores the weight
# md_mob_is_hostile
# md_mob_is_night
# md_mob_is_nether

# md_mobs_selected: what mobs are selected

# New target logic:
# roll a random number to determine day/night weight
# roll a random number from 1 to X to determine mob chosen (X is found at game start)
# walk through list of mobs:
#   if mob weight <= mob chosen #, this is the mob chosen
#   otherwiste, subtract mob weight from mob chosen #

