# Switch between difficulty scaling options

scoreboard players add $DifficultySpeed md_state 1
execute unless score $DifficultySpeed md_state matches 1..2 run scoreboard players set $DifficultySpeed md_state 0

function mob_dash:menu/settings/update_difficulty_speed_text
function mob_dash:menu/display_menu