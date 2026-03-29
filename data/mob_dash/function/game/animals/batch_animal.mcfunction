# Put a portion of all animals in batches to check for despawn later
# Proportion of animals that are batched
# = $AnimalDespawnChance_Base / $AnimalTotalChance_Base
# Batch #s are 1-19

scoreboard players add #batch_chance md_state 1
execute if score #batch_chance md_state > $AnimalTotalChance_Base md_animal_config run return run scoreboard players set #batch_chance md_state 0
execute if score #batch_chance md_state > $AnimalDespawnChance_Base md_animal_config run return 1

# Increment by 8 each step to evenly distribute few mobs
scoreboard players add #despawn_batch md_state 8
execute if score #despawn_batch md_state matches 20.. run scoreboard players remove #despawn_batch md_state 19
scoreboard players operation @s md_batch_idx = #despawn_batch md_state
tag @s add md_despawn_batched

function mob_dash:game/animals/debug_glowing