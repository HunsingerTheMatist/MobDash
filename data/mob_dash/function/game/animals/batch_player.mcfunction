# Assign this player to a spawn batch (0..2). Caller: 'prepare_cycle'

scoreboard players operation @s md_batch_id = #next_player_batch md_state
scoreboard players add #next_player_batch md_state 1
execute if score #next_player_batch md_state matches 3.. run scoreboard players set #next_player_batch md_state 0
