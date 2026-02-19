# If the current mob's weight is <= $MobChoice then it is the selected mob
execute if score $MobChoice md_state <= @s md_weight run return run tag @s add md_selected_new

#execute if score $MobChoice md_state matches 0 run tellraw @a [{"text": "Mob Chosen: "},{"nbt":"CustomName","entity":"@s"}]

# Otherwise keep looking
scoreboard players operation $MobChoice md_state -= @s md_weight