# Switch between difficulty scaling options

scoreboard players add $DifficultySpeed md_setting 1
execute unless score $DifficultySpeed md_setting matches 1..2 run scoreboard players set $DifficultySpeed md_setting 0

function mob_dash:menu/settings/update_difficulty_speed_text
execute as @a[tag=!md_tutorial] run function mob_dash:menu/push_menu
