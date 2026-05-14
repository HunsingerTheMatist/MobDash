# Apply bit 16 of #dx to the execution position
execute unless score #dx md_state matches 16.. run return run function mob_dash:game/animals/spawn/random_position/x_bit_8
scoreboard players remove #dx md_state 16
execute positioned ~16 ~ ~ run function mob_dash:game/animals/spawn/random_position/x_bit_8
