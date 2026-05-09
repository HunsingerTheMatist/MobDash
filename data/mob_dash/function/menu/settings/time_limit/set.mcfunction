# Set the time limit

scoreboard players operation $Timeout md_setting = @s TimeLimit
execute if score $Timeout md_setting matches ..-1 run scoreboard players set $Timeout md_setting 0
scoreboard players reset @s TimeLimit

function mob_dash:menu/settings/time_limit/update_text
execute as @a[tag=!md_tutorial] run function mob_dash:menu/push_menu
