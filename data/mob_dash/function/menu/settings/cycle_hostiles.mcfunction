# Switch between hostiles being enabled and disabled

scoreboard players add $Hostiles md_state 1
execute if score $Hostiles md_state matches 2 run scoreboard players set $Hostiles md_state 0

execute if score $Hostiles md_state matches 0 run data merge storage mob_dash:data {Hostiles:"On"}
execute if score $Hostiles md_state matches 1 run data merge storage mob_dash:data {Hostiles:"Off"}

function mob_dash:menu/display_menu