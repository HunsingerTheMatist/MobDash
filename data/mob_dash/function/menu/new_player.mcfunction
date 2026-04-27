# Runs for every player on first joining the game

tp @s @n[distance=0..,type=marker,tag=md_spawn]
clear @s
xp add @s -1000 levels

function mob_dash:menu/welcome

tag @s add md_current
scoreboard players set #temp md_state 0
execute unless score @s md_team matches 1..9 store result score @s SetTeam run random value 1..8
execute unless score @s md_team matches 1..9 run function mob_dash:menu/find_empty_team
tag @s remove md_current

tag @s add md_assigned