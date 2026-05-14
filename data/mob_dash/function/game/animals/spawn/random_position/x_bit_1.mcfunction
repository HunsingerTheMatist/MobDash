# Apply bit 1 of #dx, then dispatch to the Z-axis chain. Branches on
#  #doing_pack_spawn — initial spawns (0) enter at z_bit_128 for the full ±127
#  range; pack repeats (1) enter at z_bit_8 for the ±5 range
execute if score #doing_pack_spawn md_state matches 0 unless score #dx md_state matches 1.. run return run function mob_dash:game/animals/spawn/random_position/z_bit_128
execute unless score #dx md_state matches 1.. run return run function mob_dash:game/animals/spawn/random_position/z_bit_8
scoreboard players remove #dx md_state 1
execute if score #doing_pack_spawn md_state matches 0 positioned ~1 ~ ~ run return run function mob_dash:game/animals/spawn/random_position/z_bit_128
execute positioned ~1 ~ ~ run function mob_dash:game/animals/spawn/random_position/z_bit_8
