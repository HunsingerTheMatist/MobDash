# Clean up mob stats
scoreboard players reset @s md_score
scoreboard players reset @s md_time

# Cascade the other selected mobs if necessary
execute if entity @s[tag=md_selected1] run tag @n[distance=0,type=marker,tag=md_selected2] add md_selected1
execute if entity @s[tag=md_selected1] run tag @n[distance=0,type=marker,tag=md_selected2] remove md_selected2
execute if entity @s[tag=md_selected1] run tag @n[distance=0,type=marker,tag=md_selected3] add md_selected2
execute if entity @s[tag=md_selected1] run tag @n[distance=0,type=marker,tag=md_selected3] remove md_selected3

execute if entity @s[tag=md_selected2] run tag @n[distance=0,type=marker,tag=md_selected3] add md_selected2
execute if entity @s[tag=md_selected2] run tag @n[distance=0,type=marker,tag=md_selected3] remove md_selected3

tag @s remove md_selected
tag @s remove md_selected1
tag @s remove md_selected2
tag @s remove md_selected3
tag @s remove md_killed

scoreboard players remove $TargetCount md_state 1

# Invalidate target ticking cache
execute if score $TargetCount md_state matches ..0 run scoreboard players set $TargetTick md_state 0

# Invalidate action bar cache
scoreboard players set $ActionBarTick md_state 0