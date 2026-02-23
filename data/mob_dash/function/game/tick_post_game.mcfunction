# Wait for a bit, then go to menu

scoreboard players add $GameTick md_state 1
execute if score $GameTick md_state matches 600 run function mob_dash:game/reset
execute if score $GameTick md_state matches 600 at @n[type=marker,tag=md_spawn] run function mob_dash:menu/setup_spawn