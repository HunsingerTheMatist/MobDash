# Iterate through $MobChoice number of mobs and select the last one
execute if score $MobChoice md_state matches 0 run tag @s add md_selected_new
#execute if score $MobChoice md_state matches 0 run tellraw @a [{"text": "Mob Chosen: "},{"nbt":"CustomName","entity":"@s"}]
scoreboard players remove $MobChoice md_state 1