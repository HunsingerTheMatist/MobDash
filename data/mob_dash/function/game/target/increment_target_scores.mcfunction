# Increment the target scores
scoreboard players add @e[type=marker,tag=md_selected] md_score 1
scoreboard players operation @e[type=marker,tag=md_selected] md_score < $MaxTargetScore md_state

# Change the string 'point' to 'points' since the score is now above 1
data modify storage mob_dash:data PointStringMob1 set value " points"
data modify storage mob_dash:data PointStringMob2 set value " points"
data modify storage mob_dash:data PointStringMob2 set value " points"

# Invalidate action bar cache
scoreboard players set $ActionBarTick md_state 0

# Check if an extra target needs to be added
execute if score $TargetCount md_state >= $MaxTargetCount md_state run return 1
scoreboard players set $Temp md_state 0
execute as @e[type=marker,tag=md_selected] if score @s md_score >= $AddTargetThreshold md_state run scoreboard players add $Temp md_state 1
execute if score $Temp md_state >= $TargetCount md_state run function mob_dash:game/target/add_target