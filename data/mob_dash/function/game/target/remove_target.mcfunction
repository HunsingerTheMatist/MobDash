# Clean up mob stats

scoreboard players reset @s md_score
scoreboard players reset @s md_index

tag @s remove md_selected
tag @s remove md_killed

scoreboard players remove $TargetCount md_state 1

# Invalidate target ticking cache
execute if score $TargetCount md_state matches ..0 run scoreboard players set $TargetTick md_state 0

# Invalidate action bar cache
scoreboard players set $ActionBarCache md_state 0