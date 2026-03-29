# Switch between hostiles being off, on, and off at start

scoreboard players add $Hostiles md_setting 1
execute unless score $Hostiles md_setting matches 1..2 run scoreboard players set $Hostiles md_setting 0

function mob_dash:menu/settings/update_hostiles_text
function mob_dash:menu/display_menu