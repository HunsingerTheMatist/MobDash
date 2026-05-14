# Apply bit 128 of #dz to the execution position
execute unless score #dz md_state matches 128.. run return run function mob_dash:game/animals/spawn/random_position/z_bit_64
scoreboard players remove #dz md_state 128
execute positioned ~ ~ ~128 run function mob_dash:game/animals/spawn/random_position/z_bit_64
