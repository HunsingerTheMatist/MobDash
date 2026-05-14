# Per-player spawn dispatch. For each tracked_player (y >= 30) whose
#  md_batch_id matches the current spawn batch slot:
#   1. 'tick_caches': decrements md_cache_ttl and refreshes md_density_weight +
#      md_animals_nearby if it expired. Always returns 1 so the chain
#      continues. Runs every spawn-fire tick regardless of cap state, so the
#      TTL counts down in wall-clock time
#   2. spawn_driver gate: only y >= 50 players proceed. Players below y=50
#      had their caches refreshed in step 1 so values stay fresh for when
#      they re-emerge — they just don't drive spawn rolls themselves
#   3. cap check: skip if at $AnimalPlayerCap
#   4. density check: skip on the weighted-dice fail (clumped players share
#      spawn rate ~1× per cluster; solo players retain full rate)
#   5. 'try_spawn': the actual spawn attempt
# After the cascade, the batch slot advances 0..2 for the next spawn-fire tick

execute as @a[predicate=mob_dash:tracked_player] \
    if score @s md_batch_id = #curr_spawn_batch md_state at @s \
    if function mob_dash:game/animals/spawn/tick_caches \
    if predicate mob_dash:spawn_driver \
    if score @s md_animals_nearby < $AnimalPlayerCap md_animal_config \
    if function mob_dash:game/animals/spawn/passes_player_density_check \
    run function mob_dash:game/animals/spawn/try_spawn

# Advance to the next batch slot for the next spawn-fire tick
scoreboard players add #curr_spawn_batch md_state 1
execute if score #curr_spawn_batch md_state matches 3.. run scoreboard players set #curr_spawn_batch md_state 0
