# Apply bit 2 of #dx to the execution position
execute unless score #dx md_state matches 2.. run return run function mob_dash:game/animals/spawn/random_position/x_bit_1
scoreboard players remove #dx md_state 2
execute positioned ~2 ~ ~ run function mob_dash:game/animals/spawn/random_position/x_bit_1
