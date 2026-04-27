# runs every tick

# checks to make sure the md_markers dimension is loaded
scoreboard players add #dimension_state md_state 1
execute if score #dimension_state md_state matches 100.. run scoreboard players set #dimension_state md_state 0
execute if score #dimension_state md_state matches 0 run tellraw @a [{text:"Custom dimension 'md_markers' not loaded! Try closing and re-opening the world!", color:red}]
execute in mob_dash:md_markers run scoreboard players reset #dimension_state md_state
execute if score #dimension_state md_state matches -2147483648..2147483647 run return fail

scoreboard players add $GameState md_state 0

execute if score $GameState md_state matches 0 run function mob_dash:menu/tick_menu
execute if score $GameState md_state matches 1 run function mob_dash:game/tick_pre_game
execute if score $GameState md_state matches 2 in mob_dash:md_markers positioned 0 0 0 run function mob_dash:game/tick_game
execute if score $GameState md_state matches 3 run function mob_dash:game/tick_post_game