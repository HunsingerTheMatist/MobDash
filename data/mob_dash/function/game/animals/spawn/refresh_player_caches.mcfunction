# Recompute the per-player spawn-pipeline caches:
#  - @s md_density_weight: summed per-band weight contributions from other
#     nearby players; throttles spawn rate in clusters
#  - @s md_animals_nearby: total animal count in the ±144 box; cap-check input
# Then reset @s md_cache_ttl to a randomized lifetime (5-8 seconds at 3
#  spawn-fires per cycle), randomized so refreshes spread across players over
#  time
# Runs as @s = the player, at @s
# Between refreshes, md_animals_nearby is kept accurate by incremental updates
#  in 'validate_and_summon' (+1 on each successful spawn) and 'despawn/kill'
#  (-1 on each despawn). The full recount here corrects drift from vanilla
#  spawn/despawn that doesn't go through our hooks

# #density_weight starts at 100 (self contribution); 'add_density_weight'
#  adds a band-based weight per other nearby player
scoreboard players set #density_weight md_state 100

# Tracked-but-not-driver players (30 <= y < 50) don't compete for surface
#  spawn pressure, so the iteration filters to spawn_drivers only
tag @s add md_current
execute positioned ~-144 -200 ~-144 as @a[predicate=mob_dash:spawn_driver,tag=!md_current,dx=287,dy=1000,dz=287] at @s run function mob_dash:game/animals/spawn/add_density_weight
tag @s remove md_current

# Refresh the nearby-animal count for the cap check
execute positioned ~-144 -200 ~-144 store result score @s md_animals_nearby if entity @e[type=#mob_dash:animals,dx=287,dy=1000,dz=287]

scoreboard players operation @s md_density_weight = #density_weight md_state
execute store result score @s md_cache_ttl run random value 15..24
