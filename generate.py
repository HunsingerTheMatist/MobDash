import json

level_1_mobs = [
#   Mob Name    Mob Weight  Mob Type(1=passive,2=hostile,3=night,5=nether; multiplicative)
    ['bee',		 3,	1],
    ['chicken',		 5,	1],
    ['cod',		 5,	1],
    ['cow',		 5,	1],
    ['dolphin',		 5,	1],
    ['horse',		 3,	1],
    ['pig',		 5,	1],
    ['rabbit',		 2,	1],
    ['salmon',		 5,	1],
    ['sheep',		 5,	1],
    ['squid',		 5,	1],
]

level_2_mobs = [
    ['bat',		 2,	1],
    ['creeper',		 5,	6],
    ['drowned',		 5,	6],
    ['skeleton',	 5,	6],
    ['spider',		 5,	6],
    ['zombie',		 5,	6],
]

level_3_mobs = [
    ['axolotl',      2, 1],
    ['enderman',	 5,	6],
    ['ghast',		 4,	10],
    ['glow_squid',   2, 1],
    ['goat',		 1,	1],
    ['guardian',	 1,	2],
    ['hoglin',		 5,	10],
    ['iron_golem',	 3,	1],
    ['llama',		 1,	1],
    ['magma_cube',	 3,	10],
    ['piglin',		 5,	10],
    ['strider',		 5,	5],
    ['witch',		 2,	6],
    ['zombified_piglin', 5,	10],
]

level_4_mobs = [
    ['blaze',		 3,	10],
    ['piglin_brute',	 2,	10],
    ['wither_skeleton',	 3,	10],
    ['zoglin',		 4,	10],
]

all_mobs = level_1_mobs + level_2_mobs + level_3_mobs + level_4_mobs

def get_display_name(mob):
    return mob.replace('_', ' ').title()

def get_level(mob_info):
    if mob_info in level_1_mobs:
        return 1
    elif mob_info in level_2_mobs:
        return 2
    elif mob_info in level_3_mobs:
        return 3
    elif mob_info in level_4_mobs:
        return 4
    return 0

def get_scoreboard_name(mob):
    return 'md_' + mob[:12]

#with open('data/mob_dash/function/load/create_target_scoreboards.mcfunction', 'w') as file:
#    file.write('# Create all target scoreboards (auto-generated file)\n\n')
#
#    for mob, *_ in all_mobs:
#        display_name = get_display_name(mob)
#        scoreboard_name = get_scoreboard_name(mob)
#        file.write(f'scoreboard objectives add {scoreboard_name} minecraft.killed:minecraft.{mob} "Mob Dash {display_name} Kills"\n')

with open('data/mob_dash/function/load/create_targets.mcfunction', 'w') as file:
    file.write('# Create target data (auto-generated file)\n\n')

    prev_lvl = i = 1
    for mob_info in all_mobs:
        mob = mob_info[0]
        display_name = get_display_name(mob)
        level = get_level(mob_info)
        weight = mob_info[1]
        type = mob_info[2]
        extra_tags = ''
        if type % 2 == 0:
            extra_tags += ', md_hostile'
        if type % 3 == 0:
            extra_tags += ', md_night'
        if type % 5 == 0:
            extra_tags += ', md_nether'

        if level != prev_lvl:
            file.write("\n")
        #summon marker ~ ~ ~ {CustomName:"Bee", data:{level: 1, weight: 3}, Tags:[md_target]}
        file.write(
            f'summon marker ~ ~ ~ {{CustomName:"{display_name}", '
            f'data: {{level: {level}, weight: {weight}}}, '
            f'Tags:[md_target{extra_tags}]}}\n'
        )
        prev_lvl = level
        i += 1

    file.write('\nexecute as @e[distance=0,type=marker,tag=md_target] store result score @s md_level run data get entity @s data.level')
    file.write('\nexecute as @e[distance=0,type=marker,tag=md_target] store result score @s md_weight run data get entity @s data.weight')

for mob, *_ in all_mobs:
    with open(f'data/mob_dash/advancement/kill_{mob}.json', 'w') as file:
        file.write(
            '{\n'
            '  "criteria": {\n'
            '    "requirement": {\n'
            '      "trigger": "minecraft:player_killed_entity",\n'
            '      "conditions": {\n'
            '        "entity": {\n'
            f'          "type": "minecraft:{mob}"\n'
            '        }\n'
            '      }\n'
            '    }\n'
            '  },\n'
            '  "rewards": {\n'
            f'    "function": "mob_dash:game/kill_detection/killed_{mob}"\n'
            '  }\n'
            '}'
        )
    with open(f'data/mob_dash/function/game/kill_detection/killed_{mob}.mcfunction', 'w') as file:
        display_name = get_display_name(mob)
        file.write('# Runs when the current mob has been killed (auto-generated file)\n\n')
        file.write(f'advancement revoke @s only mob_dash:kill_{mob}\n')
        file.write(f'tag @s add md_current\n')
        file.write(f'execute in mob_dash:mb_markers positioned 0 0 0 as @n[distance=0,type=marker,tag=md_selected,name="{display_name}"] run function mob_dash:game/award_kill\n')
        file.write(f'tag @s remove md_current')

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

with open('tiers.md', 'w') as file:
    file.write('### Tier 1\n')
    for mob, *_ in level_1_mobs:
        file.write(f'- {get_display_name(mob)}\n')

    file.write('\n### Tier 2\n')
    for mob, *_ in level_2_mobs:
        file.write(f'- {get_display_name(mob)}\n')

    file.write('\n### Tier 3\n')
    for mob, *_ in level_3_mobs:
        file.write(f'- {get_display_name(mob)}\n')

    file.write('\n### Tier 4\n')
    for mob, *_ in level_4_mobs:
        file.write(f'- {get_display_name(mob)}\n')

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

