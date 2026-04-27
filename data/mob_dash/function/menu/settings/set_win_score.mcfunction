# Set the winning score

scoreboard players operation $Win md_setting = @s WinScore
execute if score $Win md_setting matches ..-1 run scoreboard players set $Win md_setting 0
scoreboard players reset @s WinScore

function mob_dash:menu/settings/update_win_score_text
execute as @a[tag=!md_tutorial] run function mob_dash:menu/push_menu