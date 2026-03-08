# Put players in batches to check animal cap later
# Batch #s are 1-18

# Increment by 7 each step to evenly distribute few players
scoreboard players add #mob_cap_batch md_state 7
execute if score #mob_cap_batch md_state matches 19.. run scoreboard players remove #mob_cap_batch md_state 18
scoreboard players operation @s md_batch_idx = #mob_cap_batch md_state