# Switch between score incrementation periods

scoreboard players add $IncrementPeriod md_setting 1
execute unless score $IncrementPeriod md_setting matches 1..2 run scoreboard players set $IncrementPeriod md_setting 0

function mob_dash:menu/settings/increment_period/update_text
execute as @a[tag=!md_tutorial] run function mob_dash:menu/push_menu
