# If a player joins without a team add them to the spectator team

clear @s
xp add @s -1000 levels

scoreboard players set @s md_team 9
team join gray @s
gamemode spectator @s
tp @s @n[distance=0..,type=marker,tag=md_spawn]

tag @s add md_assigned