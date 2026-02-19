# Switch between score incrementation periods

scoreboard players add $IncrementPeriod md_state 1
execute unless score $IncrementPeriod md_state matches 1..2 run scoreboard players set $IncrementPeriod md_state 0

function mob_dash:menu/settings/update_increment_period_text
function mob_dash:menu/display_menu
