# Reset back to menu state

scoreboard players set $GameState md_state 0
scoreboard players reset * md_score
scoreboard players reset * md_player_scores

execute unless entity @e[type=marker,tag=md_spawn] run summon marker 0 0 0 {Tags:["md_spawn"]}

worldborder set 50000

scoreboard players set $BorderCooldown md_state 0
title @a title "Teleporting In:"
function mob_dash:game/relocate_display

bossbar remove mob_dash:timer
