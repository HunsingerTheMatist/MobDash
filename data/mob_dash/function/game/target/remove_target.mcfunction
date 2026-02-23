# Clean up mob stats

scoreboard players reset @s md_score
scoreboard players reset @s md_index

tag @s remove md_selected
tag @s remove md_killed

scoreboard players remove $TargetCount md_state 1

# Invalidate action bar cache
scoreboard players set $ActionBarCache md_state 0

# Check to see if a new target needs to be added
function mob_dash:game/target/check_for_add_target