# Count the number of players on team @s

tag @s add md_current
execute as @a if score @s md_team = @e[type=marker,tag=md_current,limit=1] md_team run scoreboard players add @e[type=marker,tag=md_current] md_team_count 1
tag @s remove md_current
