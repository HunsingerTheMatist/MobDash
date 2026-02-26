# Loops through the eligible mobs until it finds the right one

execute if score #temp md_state matches 1 run return 1

# If the current mob's weight is < $MobChoice then it is the selected mob
execute if score $MobChoice md_state < @s md_weight run tag @s add md_selected_new
execute if score $MobChoice md_state < @s md_weight run return run scoreboard players set #temp md_state 1

#execute if score $MobChoice md_state matches 0 run tellraw @a [{"text": "Mob Chosen: "},{"nbt":"CustomName","entity":"@s"}]

# Otherwise keep looking
scoreboard players operation $MobChoice md_state -= @s md_weight