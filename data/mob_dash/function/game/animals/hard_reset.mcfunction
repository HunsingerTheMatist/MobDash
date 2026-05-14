# Resets all animal-exclusive state. Called from 'mob_dash:hard_reset'

scoreboard players reset * animal_weight
scoreboard players reset * md_animal_config
scoreboard players reset * md_animal_spawns
scoreboard players reset * md_animals_nearby
scoreboard players reset * md_batch_id
scoreboard players reset * md_cache_ttl
scoreboard players reset * md_density_weight
scoreboard players reset * md_despawn_timer

# Animal interaction IDs and the next-id allocator
function mob_dash:game/animals/interaction/reset_all_ids

kill @e[type=marker,tag=md_debug_capture]
