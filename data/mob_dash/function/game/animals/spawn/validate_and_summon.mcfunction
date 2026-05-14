# Validates the position and dispatches the summon. Runs at the resolved
#  + snapped spawn candidate, so ~ ~ ~ is the position to validate

# Validate the spawn position
execute store result score #spawn_result md_state run function mob_dash:game/animals/spawn/check_position

# If the position is viable, pick a species and summon, overwriting
#  #spawn_result with that pass's code
execute if score #spawn_result md_state matches 1 store result score #spawn_result md_state run function mob_dash:game/animals/spawn/pick_for_biome

# Bump success counter on actual summon
execute if score #spawn_result md_state matches 1 run scoreboard players add #spawn_successes md_state 1

# Incremental md_animals_nearby update for every player whose ±144 box contains
#  the new spawn. 'refresh_player_caches' handles the periodic full recount
execute if score #spawn_result md_state matches 1 positioned ~-144 -200 ~-144 as @a[predicate=mob_dash:tracked_player,dx=287,dy=1000,dz=287] run scoreboard players add @s md_animals_nearby 1

# Debug print
execute if score #debug_animal_spawning md_animal_config matches 1 run function mob_dash:game/animals/debug/spawn_print

# If the summon set a pack-spawn budget (pack-size > 1 species), kick off the loop
execute if score #spawn_result md_state matches 1 if score #pack_attempts md_state matches 1.. run function mob_dash:game/animals/spawn/pack/try_spawn
