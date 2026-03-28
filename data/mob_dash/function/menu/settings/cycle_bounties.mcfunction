# Switch between bounties being enabled and disabled

scoreboard players add $Bounties md_state 1
execute unless score $Bounties md_state matches 1 run scoreboard players set $Bounties md_state 0

function mob_dash:menu/settings/update_bounties_text
function mob_dash:menu/display_menu