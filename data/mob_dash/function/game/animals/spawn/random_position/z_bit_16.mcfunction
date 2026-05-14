# Apply bit 16 of #dz to the execution position
execute unless score #dz md_state matches 16.. run return run function mob_dash:game/animals/spawn/random_position/z_bit_8
scoreboard players remove #dz md_state 16
execute positioned ~ ~ ~16 run function mob_dash:game/animals/spawn/random_position/z_bit_8
