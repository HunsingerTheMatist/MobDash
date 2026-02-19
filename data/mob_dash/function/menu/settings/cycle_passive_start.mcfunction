# Switch between passive start being enabled and disabled

scoreboard players add $PassiveStart md_state 1
execute unless score $PassiveStart md_state matches 1 run scoreboard players set $PassiveStart md_state 0

function mob_dash:menu/settings/update_passive_start_text
function mob_dash:menu/display_menu