execute if score $ProgressionSpeed md_state matches 0 run return run data merge storage mob_dash:data {Progression:"Slow"}
execute if score $ProgressionSpeed md_state matches 1 run return run data merge storage mob_dash:data {Progression:"Medium"}
data merge storage mob_dash:data {Progression:"Fast"}