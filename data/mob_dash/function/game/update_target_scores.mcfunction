# Update the target scores
execute as @e[type=marker,tag=md_selected] run function mob_dash:game/calculate_target_score

# Check if an extra target needs to be added
execute unless score $TargetCount md_state matches 3.. unless entity @n[type=marker,tag=md_selected,scores={md_score=..2}] run function mob_dash:game/new_target