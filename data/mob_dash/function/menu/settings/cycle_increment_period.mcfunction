# Switch between score incrementation periods

scoreboard players add $IncrementPeriod md_state 1
execute if score $IncrementPeriod md_state matches 3 run scoreboard players set $IncrementPeriod md_state 0

execute if score $IncrementPeriod md_state matches 0 run data merge storage mob_dash:data {IncrementPeriod:"1 min"}
execute if score $IncrementPeriod md_state matches 1 run data merge storage mob_dash:data {IncrementPeriod:"2 min"}
execute if score $IncrementPeriod md_state matches 2 run data merge storage mob_dash:data {IncrementPeriod:"3 min"}

function mob_dash:menu/display_menu
