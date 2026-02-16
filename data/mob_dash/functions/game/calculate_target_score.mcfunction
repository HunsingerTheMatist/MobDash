# Calculate the reward for the current target(s)

execute as @e[type=area_effect_cloud,tag=md_selected] run scoreboard players operation @s md_score = @s md_time
execute as @e[type=area_effect_cloud,tag=md_selected] run scoreboard players operation @s md_score /= $ScorePeriod md_state
execute as @e[type=area_effect_cloud,tag=md_selected] run scoreboard players add @s md_score 1

scoreboard players set $MaxedScores md_state 0
execute as @e[type=area_effect_cloud,tag=md_selected] if score @s md_score matches 3.. run scoreboard players add $MaxedScores md_state 1

execute if score $TargetCount md_state <= $MaxedScores md_state unless score $TargetCount md_state matches 3.. run function mob_dash:game/new_target
execute as @e[type=area_effect_cloud,tag=md_selected] if score @s md_score matches 6.. run scoreboard players set @s md_score 5