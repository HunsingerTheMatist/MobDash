# Per-attempt entry for the pack-spawn loop. Decrements the attempt budget,
#  validates the position, routes to the locked species, then recurses for the
#  next attempt until the budget runs out. Wasted attempts (failed 'check_position'
#  or biome mismatch on the locked species) still consume the budget — matches
#  vanilla NaturalSpawner pack semantics
# Runs at the drifted + snapped position

# Validate the drifted position
execute store result score #spawn_result md_state run function mob_dash:game/animals/spawn/check_position

# If position viable, dispatch to the locked species via 'pack/pick_for_animal',
#  which re-checks the per-animal biome tag (so a drift into an incompatible
#  biome no-ops) and runs the summon variant for that species
execute if score #spawn_result md_state matches 1 store result score #spawn_result md_state run function mob_dash:game/animals/spawn/pack/pick_for_animal

# Bump success counter on actual summon
execute if score #spawn_result md_state matches 1 run scoreboard players add #spawn_successes md_state 1

# Incremental md_animals_nearby update for every player whose ±144 box
#  contains the new pack-spawn
execute if score #spawn_result md_state matches 1 positioned ~-144 -200 ~-144 as @a[predicate=mob_dash:tracked_player,dx=287,dy=1000,dz=287] run scoreboard players add @s md_animals_nearby 1

# Debug print
execute if score #debug_animal_spawning md_animal_config matches 1 run function mob_dash:game/animals/debug/spawn_print

# Recurse for the next attempt while the budget allows it. Independent of
#  success/failure of this attempt — vanilla counts wasted attempts
execute if score #pack_attempts md_state matches 1.. run function mob_dash:game/animals/spawn/pack/try_spawn
