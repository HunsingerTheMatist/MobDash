# Starts the game after a 3 second countdown

scoreboard players add #start_wait md_state 1

execute if score #start_wait md_state matches 1 run tellraw @a [{text:"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"}]
execute if score #start_wait md_state matches 1 run title @a title "Starting In:"
execute if score #start_wait md_state matches 1 run title @a subtitle "3"
execute if score #start_wait md_state matches 21 run title @a subtitle "2"
execute if score #start_wait md_state matches 41 run title @a subtitle "1"
execute unless score #start_wait md_state matches 61.. run return 1

scoreboard players set #start_wait md_state 0
title @a clear
function mob_dash:game/start_game