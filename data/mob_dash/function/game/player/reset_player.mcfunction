
execute unless dimension overworld in overworld run return run function mob_dash:game/player/reset_player

# Remove triggers
scoreboard players add @s MenuAction 0
scoreboard players add @s TeamCount 0
scoreboard players add @s WinScore 0
scoreboard players add @s TimeLimit 0
scoreboard players add @s SetTeam 0
scoreboard players reset @s MenuAction
scoreboard players reset @s TeamCount
scoreboard players reset @s WinScore
scoreboard players reset @s TimeLimit
scoreboard players reset @s SetTeam

clear @s
effect clear @a
xp add @s -1000 levels

tp @s @n[distance=0..,type=marker,tag=md_game_spawn]
execute at @n[distance=0..,type=marker,tag=md_game_spawn] run spawnpoint @s ~ ~ ~
