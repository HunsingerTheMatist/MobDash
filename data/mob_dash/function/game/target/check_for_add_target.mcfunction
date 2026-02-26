# Check target thresholds to determine if a new target needs to be added

execute if score $TargetCount md_state >= $MaxTargetCount md_state run return 1

# If all existing targets have point values above $AddTargetThreshold, add a new target
# This also triggers if there are currently no targets
scoreboard players set #temp md_state 0
execute as @e[distance=..1,type=marker,tag=md_selected] if score @s md_score >= $AddTargetThreshold md_state run scoreboard players add #temp md_state 1
execute if score #temp md_state >= $TargetCount md_state run function mob_dash:game/target/add_target