# Apply bit 4 of #dz to the execution position
execute unless score #dz md_state matches 4.. run return run function mob_dash:game/animals/spawn/random_position/z_bit_2
scoreboard players remove #dz md_state 4
execute positioned ~ ~ ~4 run function mob_dash:game/animals/spawn/random_position/z_bit_2
