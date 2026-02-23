# Increment the target scores
scoreboard players add @e[distance=0,type=marker,tag=md_selected] md_score 1
scoreboard players operation @e[distance=0,type=marker,tag=md_selected] md_score < $MaxTargetScore md_state

# Change the string 'point' to 'points' since the score is now above 1
execute if score $MaxTargetScore md_state matches 2.. as @e[distance=0,type=marker,tag=md_selected] run data modify entity @s data.PointString set value " points"

# Invalidate action bar cache
scoreboard players set $ActionBarCache md_state 0

# Check if an extra target needs to be added
execute if score $TargetCount md_state >= $MaxTargetCount md_state run return 1
scoreboard players set #temp md_state 0
execute as @e[distance=0,type=marker,tag=md_selected] if score @s md_score >= $AddTargetThreshold md_state run scoreboard players add #temp md_state 1
execute if score #temp md_state >= $TargetCount md_state run function mob_dash:game/target/add_target