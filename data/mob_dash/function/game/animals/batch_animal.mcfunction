# Assign this animal to a despawn batch (0..9). Caller: 'prepare_cycle'

scoreboard players operation @s md_batch_id = #next_animal_batch md_state
scoreboard players add #next_animal_batch md_state 1
execute if score #next_animal_batch md_state matches 10.. run scoreboard players set #next_animal_batch md_state 0
