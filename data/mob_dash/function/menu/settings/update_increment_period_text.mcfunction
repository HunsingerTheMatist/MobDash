execute if score $IncrementPeriod md_setting matches 0 run return run data modify storage mob_dash:data Settings.IncrementPeriod set value "1 min"
execute if score $IncrementPeriod md_setting matches 1 run return run data modify storage mob_dash:data Settings.IncrementPeriod set value "2 min"
data modify storage mob_dash:data Settings.IncrementPeriod set value "3 min"
