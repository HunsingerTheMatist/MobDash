# Apply bit 8 of #dz to the execution position
execute unless score #dz md_state matches 8.. run return run function mob_dash:game/animals/spawn/random_position/z_bit_4
scoreboard players remove #dz md_state 8
execute positioned ~ ~ ~8 run function mob_dash:game/animals/spawn/random_position/z_bit_4
