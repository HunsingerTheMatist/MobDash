# Finds the animal with the id that was interacted with and marks it as persistent
# Runs when the 'interact_with_animal' advancement is awarded
# Credit: https://github.com/picarrow/hit-match

execute if score $UseAnimalDespawning md_animal_config matches 0 run return 1

# Exit early if the mob that was interacted with does not have an id
execute if entity @s[advancements={mob_dash:interact_with_animal={no_id=true}}] run return run advancement revoke @s only mob_dash:interact_with_animal

# Rebuild the id from the matching base 3 bits
scoreboard players set #id md_state 0
execute if entity @s[advancements={mob_dash:interact_with_animal={bit_0_1=true}}] run scoreboard players add #id md_state 1
execute if entity @s[advancements={mob_dash:interact_with_animal={bit_0_2=true}}] run scoreboard players add #id md_state 2
execute if entity @s[advancements={mob_dash:interact_with_animal={bit_1_1=true}}] run scoreboard players add #id md_state 3
execute if entity @s[advancements={mob_dash:interact_with_animal={bit_1_2=true}}] run scoreboard players add #id md_state 6
execute if entity @s[advancements={mob_dash:interact_with_animal={bit_2_1=true}}] run scoreboard players add #id md_state 9
execute if entity @s[advancements={mob_dash:interact_with_animal={bit_2_2=true}}] run scoreboard players add #id md_state 18
execute if entity @s[advancements={mob_dash:interact_with_animal={bit_3_1=true}}] run scoreboard players add #id md_state 27
execute if entity @s[advancements={mob_dash:interact_with_animal={bit_3_2=true}}] run scoreboard players add #id md_state 54
execute if entity @s[advancements={mob_dash:interact_with_animal={bit_4_1=true}}] run scoreboard players add #id md_state 81
execute if entity @s[advancements={mob_dash:interact_with_animal={bit_4_2=true}}] run scoreboard players add #id md_state 162
execute if entity @s[advancements={mob_dash:interact_with_animal={bit_5_1=true}}] run scoreboard players add #id md_state 243
execute if entity @s[advancements={mob_dash:interact_with_animal={bit_5_2=true}}] run scoreboard players add #id md_state 486
execute if entity @s[advancements={mob_dash:interact_with_animal={bit_6_1=true}}] run scoreboard players add #id md_state 729
execute if entity @s[advancements={mob_dash:interact_with_animal={bit_6_2=true}}] run scoreboard players add #id md_state 1458
execute if entity @s[advancements={mob_dash:interact_with_animal={bit_7_1=true}}] run scoreboard players add #id md_state 2187
execute if entity @s[advancements={mob_dash:interact_with_animal={bit_7_2=true}}] run scoreboard players add #id md_state 4374
execute if entity @s[advancements={mob_dash:interact_with_animal={bit_8_1=true}}] run scoreboard players add #id md_state 6561
execute if entity @s[advancements={mob_dash:interact_with_animal={bit_8_2=true}}] run scoreboard players add #id md_state 13122

advancement revoke @s only mob_dash:interact_with_animal

# Try to find the animal with the calculated id and process it
execute if score #id md_state matches 1..19682 as @e[type=#mob_dash:non_persistent_animals,distance=..20,tag=!md_persistent,sort=nearest] if score @s md_id = #id md_state run return run function mob_dash:game/animals/interaction/process_interaction
execute unless score #debug_animal_handling md_animal_config matches 0 run tellraw @a [{text:"FAILED TO FIND ANIMAL WITH ID ",color:red},{score:{objective:md_state,name:"#id"},color:white},{text:" INTERACTED BY "},{selector:"@s"}]