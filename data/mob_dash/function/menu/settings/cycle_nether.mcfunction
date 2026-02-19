# Switch between nether mobs being enabled and disabled

scoreboard players add $Nether md_state 1
execute unless score $Nether md_state matches 1 run scoreboard players set $Nether md_state 0

function mob_dash:menu/settings/update_nether_text
function mob_dash:menu/display_menu