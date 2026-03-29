# Runs every tick when the game is running

# Process whether the $UseAnimalDespawning toggle is on or not
execute if score $UseAnimalDespawning md_animal_config matches 0 run return run function mob_dash:game/animals/disable_animal_handling
execute if score #prev_use_animal_despawning md_state matches 0 run function mob_dash:game/animals/enable_animal_handling

# Add new interaction ids to relevant animals that don't have one
function mob_dash:game/animals/interaction/assign_missing_ids

# Increment the loop iterators (animal_spawn_tick is modulo 400, animal_spawn_tick20 is modulo 20)
scoreboard players add #animal_spawn_tick md_state 1
scoreboard players add #animal_spawn_tick20 md_state 1

# Stagger batch processing across tick phases to distribute load
# - despawn batches run on tick20 phase 20
# - mob cap batches run on tick20 phase 10
execute if score #animal_spawn_tick20 md_state matches 20 if score #animal_spawn_tick md_state matches 20..380 run function mob_dash:game/animals/despawn/process_despawn_batch
execute if score #animal_spawn_tick20 md_state matches 10 if score #animal_spawn_tick md_state matches 30..370 run function mob_dash:game/animals/mob_cap/process_mob_cap_batch

# Cycle the 20-tick iterator
execute if score #animal_spawn_tick20 md_state matches 20.. run scoreboard players set #animal_spawn_tick20 md_state 0
execute unless score #animal_spawn_tick md_state matches 400.. run return 1

# End of the 400-tick cycle: preprocess all animal logic before the next cycle begins, and reset all iterators
function mob_dash:game/animals/preprocess_all
scoreboard players set #animal_spawn_tick md_state 0
scoreboard players set #animal_spawn_tick20 md_state 0
scoreboard players set #curr_despawn_batch md_state 0
scoreboard players set #curr_mob_cap_batch md_state 0