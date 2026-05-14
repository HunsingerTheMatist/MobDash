# Pack-attempt entry. Rolls a triangular [-5, +5] offset on each horizontal
#  axis (two 0..5 rolls summed give 0..10 peaking at 5; the ~-5 anchor below
#  shifts to -5..+5 peaking at 0 — matches vanilla NaturalSpawner spreading)
# Callers: 'validate_and_summon', 'pack/validate_and_summon'. Runs at the
#  current attempt position

# Mark as pack attempt for the chain branches and 'debug/spawn_print' prefix
scoreboard players set #doing_pack_spawn md_state 1

scoreboard players add #spawn_attempts md_state 1
scoreboard players remove #pack_attempts md_state 1

execute store result score #dx md_state run random value 0..5
execute store result score #dx_b md_state run random value 0..5
scoreboard players operation #dx md_state += #dx_b md_state

execute store result score #dz md_state run random value 0..5
execute store result score #dz_b md_state run random value 0..5
scoreboard players operation #dz md_state += #dz_b md_state

# Anchor at -5, -5 and dive into the X-axis chain (start at bit_8 since max
#  #dx is 10, which 8+4+2+1 covers), unless both axes rolled to the no-offset
#  result (sum 5 → 0 shift after the -5 anchor)
execute unless score #dx md_state matches 5 positioned ~-5 ~ ~-5 run return run function mob_dash:game/animals/spawn/random_position/x_bit_8
execute unless score #dz md_state matches 5 positioned ~-5 ~ ~-5 run return run function mob_dash:game/animals/spawn/random_position/x_bit_8

# Short-circuit: dx == 5 AND dz == 5, same position as previous spawn
scoreboard players set #spawn_result md_state -24
execute if score #debug_animal_spawning md_animal_config matches 1 run function mob_dash:game/animals/debug/spawn_print
execute if score #pack_attempts md_state matches 1.. run function mob_dash:game/animals/spawn/pack/try_spawn
