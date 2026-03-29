# Set the time limit

scoreboard players operation $Timeout md_setting = @s TimeLimit
execute if score $Timeout md_setting matches ..-1 run scoreboard players set $Timeout md_setting 0
scoreboard players reset @s TimeLimit

function mob_dash:menu/settings/update_time_limit_text
function mob_dash:menu/display_menu