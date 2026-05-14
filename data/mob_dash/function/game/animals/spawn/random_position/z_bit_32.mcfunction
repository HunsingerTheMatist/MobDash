# Apply bit 32 of #dz to the execution position
execute unless score #dz md_state matches 32.. run return run function mob_dash:game/animals/spawn/random_position/z_bit_16
scoreboard players remove #dz md_state 32
execute positioned ~ ~ ~32 run function mob_dash:game/animals/spawn/random_position/z_bit_16
