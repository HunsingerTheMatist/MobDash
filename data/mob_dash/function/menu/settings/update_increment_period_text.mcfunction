execute if score $IncrementPeriod md_state matches 0 run return run data merge storage mob_dash:data {IncrementPeriod:"1 min"}
execute if score $IncrementPeriod md_state matches 1 run return run data merge storage mob_dash:data {IncrementPeriod:"2 min"}
data merge storage mob_dash:data {IncrementPeriod:"3 min"}