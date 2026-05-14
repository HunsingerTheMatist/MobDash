# Apply bit 2 of #dz to the execution position
execute unless score #dz md_state matches 2.. run return run function mob_dash:game/animals/spawn/random_position/z_bit_1_and_snap
scoreboard players remove #dz md_state 2
execute positioned ~ ~ ~2 run function mob_dash:game/animals/spawn/random_position/z_bit_1_and_snap
