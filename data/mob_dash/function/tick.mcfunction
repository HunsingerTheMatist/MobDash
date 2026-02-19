# runs every tick

scoreboard players add $GameState md_state 0

execute if score $GameState md_state matches 0 run function mob_dash:menu/tick_menu
execute if score $GameState md_state matches 1 run function mob_dash:game/tick_game
execute if score $GameState md_state matches 2 run function mob_dash:game/tick_post_game

execute if entity @a[scores={HardReset=1..}] run function mob_dash:load/hard_reset
scoreboard players set @a HardReset 0