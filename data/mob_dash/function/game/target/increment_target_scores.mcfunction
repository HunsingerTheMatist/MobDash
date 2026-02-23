# Increment the target scores
scoreboard players add @e[distance=0,type=marker,tag=md_selected] md_score 1
scoreboard players operation @e[distance=0,type=marker,tag=md_selected] md_score < $MaxTargetScore md_state

# Change the string 'point' to 'points' since the score is now above 1
execute if score $MaxTargetScore md_state matches 2.. as @e[distance=0,type=marker,tag=md_selected] run data modify entity @s data.PointString set value " points"

# Set the next score increment time
scoreboard players operation $TargetTick md_state = $ScorePeriod md_state

# Invalidate action bar cache
scoreboard players set $ActionBarCache md_state 0

# Check if a new target needs to be added
function mob_dash:game/target/check_for_add_target