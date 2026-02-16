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
    ['piglin_brute',	 2,	10]
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

with open('data/mob_dash/functions/load/create_target_scoreboards.mcfunction', 'w') as file:
    file.write('# Create all target scoreboards (auto-generated file)\n\n')

    for mob, *_ in all_mobs:
        display_name = get_display_name(mob)
        scoreboard_name = get_scoreboard_name(mob)
        file.write('scoreboard objectives add ' + scoreboard_name + ' minecraft.killed:minecraft.' + mob + ' "Mob Dash ' + display_name + ' Kills"\n')

with open('data/mob_dash/functions/load/create_targets.mcfunction', 'w') as file:
    file.write('# Create target data (auto-generated file)\n\n')

    i = 1
    for mob_info in all_mobs:
        mob = mob_info[0]
        display_name = get_display_name(mob)
        level = get_level(mob_info)
        weight = mob_info[1]
        type = mob_info[2]
        extra_tags = ''
        if type % 2 == 0:
            extra_tags += ',"md_hostile"'
        if type % 3 == 0:
            extra_tags += ',"md_night"'
        if type % 5 == 0:
            extra_tags += ',"md_nether"'
        if i < 3:
            extra_tags += ',"md_random"'
        if i < 2:
            extra_tags += ',"md_true"'

        file.write('summon area_effect_cloud ~ 1 ~ {Duration:2147483647,Tags:["md_target","md_level_' + str(level) + '","md_weight_' + str(weight) + '"' + extra_tags + '], CustomName:\'"' + display_name + '"\', Color:' + str(i) + '}\n')
        i += 1

    file.write('\nexecute as @e[type=area_effect_cloud,tag=md_target] store result score @s md_target run data get entity @s Color\n')
    for i in range(1, 5):
        file.write('scoreboard players set @e[type=area_effect_cloud,tag=md_level_' + str(i) + '] md_level ' + str(i) + '\n')
    file.write('\n')
    for i in range(1, 6):
        file.write('scoreboard players set @e[type=area_effect_cloud,tag=md_weight_' + str(i) + '] md_weight ' + str(i) + '\n')

with open('data/mob_dash/functions/game/detect_kill.mcfunction', 'w') as file:
    file.write('# Detect if a target has been killed (auto-generated file)\n\n')

    i = 1
    for mob, *_ in all_mobs:
        scoreboard_name = get_scoreboard_name(mob)
        file.write('execute as @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=' + str(i) + '}] if entity @a[scores={' + scoreboard_name + '=1..}] run tag @s add md_killed\n')
        file.write('execute if entity @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=' + str(i) + '}] as @a[scores={' + scoreboard_name + '=1..}] run function mob_dash:game/award_kill\n')
        file.write('scoreboard players reset * ' + scoreboard_name + '\n')
        i += 1

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