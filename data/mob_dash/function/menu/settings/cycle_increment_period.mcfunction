# Switch between score incrementation periods

scoreboard players add $IncrementPeriod md_setting 1
execute unless score $IncrementPeriod md_setting matches 1..2 run scoreboard players set $IncrementPeriod md_setting 0

function mob_dash:menu/settings/update_increment_period_text
function mob_dash:menu/display_menu
