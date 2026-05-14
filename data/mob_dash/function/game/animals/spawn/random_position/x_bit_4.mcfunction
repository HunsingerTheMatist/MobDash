# Apply bit 4 of #dx to the execution position
execute unless score #dx md_state matches 4.. run return run function mob_dash:game/animals/spawn/random_position/x_bit_2
scoreboard players remove #dx md_state 4
execute positioned ~4 ~ ~ run function mob_dash:game/animals/spawn/random_position/x_bit_2
