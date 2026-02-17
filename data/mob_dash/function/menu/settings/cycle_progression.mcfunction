# Switch between progression speeds

scoreboard players add $ProgressionSpeed md_state 1
execute if score $ProgressionSpeed md_state matches 3 run scoreboard players set $ProgressionSpeed md_state 0

execute if score $ProgressionSpeed md_state matches 0 run data merge storage mob_dash:data {Progression:"Slow"}
execute if score $ProgressionSpeed md_state matches 1 run data merge storage mob_dash:data {Progression:"Medium"}
execute if score $ProgressionSpeed md_state matches 2 run data merge storage mob_dash:data {Progression:"Fast"}

function mob_dash:menu/display_menu
