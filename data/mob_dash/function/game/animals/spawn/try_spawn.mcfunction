# Per-player entry point for a spawn attempt. Rolls a random offset and
#  dispatches the binary-search chain that ends at the snapped spawn position
#  and calls 'validate_and_summon' there. Runs as @s = the player, at @s

# If the spawn-rate multiplier is below 100, roll 1..100 and skip the spawn
#  if the roll exceeds it
execute unless score $AnimalSpawnRateMultiplier md_animal_config matches 100 \
    store result score #spawn_rate_roll md_state run random value 1..100
execute unless score $AnimalSpawnRateMultiplier md_animal_config matches 100 \
    if score #spawn_rate_roll md_state > $AnimalSpawnRateMultiplier md_animal_config run return fail

# Initial-spawn flag (vs. pack-attempt); 0 = initial, 1 = pack repeat
scoreboard players set #doing_pack_spawn md_state 0

# Per-attempt pack-spawn budget; the picked species' summon variant rolls it
#  up to (min-1)..(max-1) when pack-size > 1
scoreboard players set #pack_attempts md_state 0

# Picked-species ID, written by the matching summon variant. -1 sentinel
#  covers the "no animal picked" case, decoded as "None" by 'debug/decode_animal_name'
scoreboard players set #picked_animal_id md_state -1

scoreboard players add #spawn_attempts md_state 1

# Roll dx, dz in [0, 254]. The chain applies them as 8-bit binary offsets
#  on top of the ~-127 base, so final position is uniformly distributed in
#  [-127, +127] on each axis around the player
execute store result score #dx md_state run random value 0..254
execute store result score #dz md_state run random value 0..254

# Align to the player's block corner so the chain operates on integer-aligned
#  coordinates (the chain shifts by integer N, and summons use `~0.5 ~ ~0.5`
#  to land at block center — both rely on the base being integer). Then anchor
#  at the SW corner of the search square and dive into the X-axis chain. The
#  chain shifts the execution position by dx, then dz, snaps Y to ground, and
#  finally calls 'validate_and_summon'
execute align xz positioned ~-127 ~ ~-127 run function mob_dash:game/animals/spawn/random_position/x_bit_128
