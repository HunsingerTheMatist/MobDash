# Switch between passive start being enabled and disabled

scoreboard players add $PassiveStart md_state 1
execute if score $PassiveStart md_state matches 2 run scoreboard players set $PassiveStart md_state 0

execute if score $PassiveStart md_state matches 0 run data merge storage mob_dash:data {PassiveStart:"On"}
execute if score $PassiveStart md_state matches 1 run data merge storage mob_dash:data {PassiveStart:"Off"}

function mob_dash:menu/display_menu