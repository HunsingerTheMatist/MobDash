# Switch between hostiles being enabled and disabled

scoreboard players add $Hostiles md_state 1
execute unless score $Hostiles md_state matches 1 run scoreboard players set $Hostiles md_state 0

function mob_dash:menu/settings/update_hostiles_text
function mob_dash:menu/display_menu