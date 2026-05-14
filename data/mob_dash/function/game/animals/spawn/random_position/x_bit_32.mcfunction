# Apply bit 32 of #dx to the execution position
execute unless score #dx md_state matches 32.. run return run function mob_dash:game/animals/spawn/random_position/x_bit_16
scoreboard players remove #dx md_state 32
execute positioned ~32 ~ ~ run function mob_dash:game/animals/spawn/random_position/x_bit_16
