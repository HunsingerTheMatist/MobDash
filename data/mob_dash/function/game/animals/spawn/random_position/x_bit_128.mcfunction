# Apply bit 128 of #dx to the execution position
execute unless score #dx md_state matches 128.. run return run function mob_dash:game/animals/spawn/random_position/x_bit_64
scoreboard players remove #dx md_state 128
execute positioned ~128 ~ ~ run function mob_dash:game/animals/spawn/random_position/x_bit_64
