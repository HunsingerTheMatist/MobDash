# Check target thresholds to determine if a new target needs to be added

execute if score $TargetCount md_state >= $MaxTargetCount md_state run return 1

# Delay this function if necessary to prevent title overlap
execute if score #new_target_delay md_state matches 1.. run return run schedule function mob_dash:game/target/check_for_add_target 1
execute unless dimension mob_dash:mb_markers in mob_dash:mb_markers positioned 0 0 0 run return run function mob_dash:game/target/check_for_add_target

# If all existing targets have point values above $AddTargetThreshold, add a new target
# This also triggers if there are currently no targets
scoreboard players set #temp md_state 0
execute as @e[distance=..1,type=marker,tag=md_target,tag=md_selected] if score @s md_score >= $AddTargetThreshold md_state run scoreboard players add #temp md_state 1
execute if score #temp md_state >= $TargetCount md_state run function mob_dash:game/target/add_target