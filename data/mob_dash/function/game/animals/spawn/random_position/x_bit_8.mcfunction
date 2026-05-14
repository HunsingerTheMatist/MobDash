# Apply bit 8 of #dx to the execution position
execute unless score #dx md_state matches 8.. run return run function mob_dash:game/animals/spawn/random_position/x_bit_4
scoreboard players remove #dx md_state 8
execute positioned ~8 ~ ~ run function mob_dash:game/animals/spawn/random_position/x_bit_4
