execute if score $DifficultySpeed md_state matches 0 run return run data merge storage mob_dash:data {DifficultySpeed:"Slow"}
execute if score $DifficultySpeed md_state matches 1 run return run data merge storage mob_dash:data {DifficultySpeed:"Normal"}
data merge storage mob_dash:data {DifficultySpeed:"Fast"}