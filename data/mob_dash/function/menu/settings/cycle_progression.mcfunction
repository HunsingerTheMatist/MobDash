# Switch between progression speeds

scoreboard players add $ProgressionSpeed md_state 1
execute unless score $ProgressionSpeed md_state matches 1..2 run scoreboard players set $ProgressionSpeed md_state 0

function mob_dash:menu/settings/update_progression_text
function mob_dash:menu/display_menu
