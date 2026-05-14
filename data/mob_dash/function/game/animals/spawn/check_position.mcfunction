# Validates that the current executor position is a viable spawn spot
#
# Return codes (captured via `store result`). Codes are grouped: -10..-19 for
#  biome reasons, -20..-29 for position/local reasons. See 'spawn_print'
#    1  position is viable
#  -10  biome has no native creature spawns
#  -20  block collision (body block isn't air-like)
#  -23  player within 24 blocks
#  -25  another animal within 5 blocks (primary spawns only)

# Fast path: bail if the biome has no native animal spawns at all (deep ocean,
#  rivers, deserts, caves, etc.). Tag is auto-generated from vanilla biome data
execute if biome ~ ~ ~ #mob_dash:no_animal_spawns run return -10

# Body block must allow spawning inside
execute unless block ~ ~ ~ #mob_dash:allow_spawning_inside run return -20

# Reject if any tracked_player is within 24 blocks
execute if entity @p[predicate=mob_dash:tracked_player,distance=..24] run return -23

# Primary spawns only: reject if another despawnable animal is within 5 blocks
#  Pack repeats skip this check, they intentionally land near the pack origin
execute if score #doing_pack_spawn md_state matches 0 if entity @n[type=#mob_dash:despawnable_animals,distance=..5] run return -25

return 1
