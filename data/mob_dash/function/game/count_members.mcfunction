# Count the number of players on team @s

tag @s add md_current
execute as @a if score @s md_team = @n[type=marker,tag=md_current] md_team run scoreboard players add @n[type=marker,tag=md_current] md_team_count 1
tag @s remove md_current