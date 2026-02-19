# Get the choice range for selecting mobs, determined by the number of eligible mobs & their weights
scoreboard players set $MaxChoice md_state 0
execute as @e[type=marker,tag=md_eligible] run scoreboard players operation $MaxChoice md_state += @s md_weight

# Randomize a number from [1-$MaxChoice]
execute store result score $MobChoice md_state run random value 0..1000000
scoreboard players operation $MobChoice md_state %= $MaxChoice md_state
scoreboard players add $MobChoice md_state 1

# Find and select the mob
execute as @e[type=marker,tag=md_eligible] run function mob_dash:game/target/get_mob_from_choice

#tellraw @a [{"text": "$MobChoice: "},{"score":{"objective": "md_state", "name": "$MobChoice"}}]
#tellraw @a [{"text": "Md Target: "},{"score":{"objective": "md_target", "name": "@e[type=marker,tag=md_selected_new,limit=1]"}}]