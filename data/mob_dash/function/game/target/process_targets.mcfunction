# Process the current targets

execute if score #new_target_delay md_state matches 1.. run scoreboard players remove #new_target_delay md_state 1

scoreboard players set #score_changed md_state 0
execute as @e[distance=..1,type=marker,tag=md_target,tag=md_selected] run function mob_dash:game/target/calculate_target_score

# If no score changed return early
execute if score #score_changed md_state matches 0 run return fail

# Change the string 'point' to 'points' if the target's score is above 1
execute if score $MaxTargetScore md_config matches 2.. as @e[distance=..1,type=marker,tag=md_target,tag=md_selected] if score @s md_score matches 2.. run data modify entity @s data.PointString set value " points"

# Invalidate action bar cache
scoreboard players set $ActionBarCache md_state 0
