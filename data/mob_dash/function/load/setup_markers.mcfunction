# If necessary, sets up the markers for the teams & targets

execute in mob_dash:mb_markers positioned 0 0 0 unless entity @n[distance=..1,type=minecraft:marker,tag=md_team] run function mob_dash:load/create_teams
execute in mob_dash:mb_markers positioned 0 0 0 unless entity @n[distance=..1,type=minecraft:marker,tag=md_target] run function mob_dash:load/create_targets