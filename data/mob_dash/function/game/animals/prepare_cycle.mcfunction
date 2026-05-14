# Heavy end-of-cycle work that sets up state for the next 20-tick cycle
#  1. Reset the dispatch counters so 'despawn/tick' and 'spawn/tick' start fresh
#  2. Mark newly-eligible animals as persistent (so the rebatch excludes them)
#  3. Reassign md_batch_id to every non-persistent despawnable animal (0..9) and
#     every tracked_player (0..2) so the 10 despawn-batch ticks each see ~1/10
#     of the eligible animal pool, and the 9 spawn-fire ticks each see ~1/3 of
#     the tracked players
# md_animals_nearby is refreshed inside 'refresh_player_caches' (the per-player
#  density cache) and kept accurate between recomputes by ±1 increments at
#  spawn/despawn sites

# Reset dispatch counters for the next cycle
scoreboard players set #curr_despawn_batch md_state 0
scoreboard players set #curr_spawn_batch md_state 0

# Mark animals as permanently persistent:
# - All baby mobs that are within 24 blocks of a player (assumed to have been bred)
# - All mobs spawned as persistent in structures (ex: cows in villages)
execute as @e[type=#mob_dash:non_persistent_animals,tag=!md_persistent,tag=!md_custom_spawned,predicate=mob_dash:is_baby] \
    if entity @p[gamemode=!spectator,distance=..24] run function mob_dash:game/animals/mark_persistent
execute as @e[type=#mob_dash:non_persistent_animals,tag=!md_structure_persistence_checked] run function mob_dash:game/animals/check_structure_persistence

# half_cap = cap/2, third_cap = cap/3. Read by 'despawn/roll's cap-fullness
#  reduction
scoreboard players operation #half_cap md_state = $AnimalPlayerCap md_animal_config
scoreboard players operation #half_cap md_state /= 2 md_const

scoreboard players operation #third_cap md_state = $AnimalPlayerCap md_animal_config
scoreboard players operation #third_cap md_state /= 3 md_const

# Rebatch: assign each non-persistent despawnable animal to one of 10 buckets,
#  and each tracked_player to one of 3 spawn-fire buckets
execute as @e[type=#mob_dash:despawnable_animals,tag=!md_persistent,sort=random] run function mob_dash:game/animals/batch_animal
execute as @a[predicate=mob_dash:tracked_player,sort=random] run function mob_dash:game/animals/batch_player
