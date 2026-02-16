# Reset back to menu state

scoreboard players set $State md_state 0
scoreboard players reset * md_score
scoreboard players reset * md_player_scores

execute unless entity @e[type=area_effect_cloud,tag=md_spawn] run summon area_effect_cloud ~ 1 ~ {Duration:2147483647,Tags:["md_spawn"]}

worldborder set 50000

scoreboard players set $BorderCooldown md_state 0
title @a title "Teleporting In:"
function mob_dash:game/relocate_display

bossbar remove mob_dash:timer
