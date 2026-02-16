# Clean up mob stats
scoreboard players set @e[type=area_effect_cloud,tag=md_killed] md_score 0
scoreboard players set @e[type=area_effect_cloud,tag=md_killed] md_time 0

# Cascade the other selected mobs if necessary
execute if entity @e[type=area_effect_cloud,tag=md_killed,tag=md_selected1] run tag @e[type=area_effect_cloud,tag=md_selected2] add md_selected1
execute if entity @e[type=area_effect_cloud,tag=md_killed,tag=md_selected1] run tag @e[type=area_effect_cloud,tag=md_selected2] remove md_selected2
execute if entity @e[type=area_effect_cloud,tag=md_killed,tag=md_selected1] run tag @e[type=area_effect_cloud,tag=md_selected3] add md_selected2
execute if entity @e[type=area_effect_cloud,tag=md_killed,tag=md_selected1] run tag @e[type=area_effect_cloud,tag=md_selected3] remove md_selected3

execute if entity @e[type=area_effect_cloud,tag=md_killed,tag=md_selected2] run tag @e[type=area_effect_cloud,tag=md_selected3] add md_selected2
execute if entity @e[type=area_effect_cloud,tag=md_killed,tag=md_selected2] run tag @e[type=area_effect_cloud,tag=md_selected3] remove md_selected3

tag @e[type=area_effect_cloud,tag=md_killed] remove md_selected1
tag @e[type=area_effect_cloud,tag=md_killed] remove md_selected2
tag @e[type=area_effect_cloud,tag=md_killed] remove md_selected3
tag @e[type=area_effect_cloud,tag=md_killed] remove md_selected
tag @e[type=area_effect_cloud,tag=md_killed] remove md_killed
scoreboard players remove $TargetCount md_state 1