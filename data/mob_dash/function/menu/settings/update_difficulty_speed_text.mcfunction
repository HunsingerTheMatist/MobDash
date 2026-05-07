execute if score $DifficultySpeed md_setting matches 0 run return run data modify storage mob_dash:data Settings.DifficultySpeed set value Slow
execute if score $DifficultySpeed md_setting matches 1 run return run data modify storage mob_dash:data Settings.DifficultySpeed set value Normal
data modify storage mob_dash:data Settings.DifficultySpeed set value Fast
