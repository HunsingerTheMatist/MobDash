# Wait for a bit, then go to menu

scoreboard players add $GameTick md_state 1
execute unless score $GameTick md_state matches 600 run return 1

tp @a @n[type=marker,tag=md_spawn]
function mob_dash:menu/reset
execute at @n[type=marker,tag=md_spawn] run function mob_dash:menu/setup_spawn