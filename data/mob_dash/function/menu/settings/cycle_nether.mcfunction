# Switch between nether mobs being enabled and disabled

scoreboard players add $Nether md_state 1
execute if score $Nether md_state matches 2 run scoreboard players set $Nether md_state 0

execute if score $Nether md_state matches 0 run data merge storage mob_dash:data {Nether:"On"}
execute if score $Nether md_state matches 1 run data merge storage mob_dash:data {Nether:"Off"}

function mob_dash:menu/display_menu