# Apply bit 64 of #dz to the execution position
execute unless score #dz md_state matches 64.. run return run function mob_dash:game/animals/spawn/random_position/z_bit_32
scoreboard players remove #dz md_state 64
execute positioned ~ ~ ~64 run function mob_dash:game/animals/spawn/random_position/z_bit_32
