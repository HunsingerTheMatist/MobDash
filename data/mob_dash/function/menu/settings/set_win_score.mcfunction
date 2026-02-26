# Set the winning score

scoreboard players operation $Win md_state = @s WinScore
execute if score $Win md_state matches ..-1 run scoreboard players set $Win md_state 0
scoreboard players reset @s WinScore

function mob_dash:menu/settings/update_win_score_text
function mob_dash:menu/display_menu