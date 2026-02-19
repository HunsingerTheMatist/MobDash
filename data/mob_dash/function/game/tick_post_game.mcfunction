# Wait for a bit, then go to menu

scoreboard players add $GameTick md_state 1
execute if score $GameTick md_state matches 600 run function mob_dash:game/reset

clear @a[gamemode=!spectator]
gamemode spectator @a[gamemode=!spectator]
