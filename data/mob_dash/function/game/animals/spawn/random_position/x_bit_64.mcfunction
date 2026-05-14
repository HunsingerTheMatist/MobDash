# Apply bit 64 of #dx to the execution position
execute unless score #dx md_state matches 64.. run return run function mob_dash:game/animals/spawn/random_position/x_bit_32
scoreboard players remove #dx md_state 64
execute positioned ~64 ~ ~ run function mob_dash:game/animals/spawn/random_position/x_bit_32
