# Apply bit 1 of #dz, then snap Y to the topmost non-leaves motion-blocking
#  block and dispatch to 'validate_and_summon' (initial spawn) or
#  'pack/validate_and_summon' (pack repeat) based on #doing_pack_spawn
execute if score #doing_pack_spawn md_state matches 0 unless score #dz md_state matches 1.. positioned over motion_blocking_no_leaves run return run function mob_dash:game/animals/spawn/validate_and_summon
execute unless score #dz md_state matches 1.. positioned over motion_blocking_no_leaves run return run function mob_dash:game/animals/spawn/pack/validate_and_summon
scoreboard players remove #dz md_state 1
execute if score #doing_pack_spawn md_state matches 0 positioned ~ ~ ~1 positioned over motion_blocking_no_leaves run return run function mob_dash:game/animals/spawn/validate_and_summon
execute positioned ~ ~ ~1 positioned over motion_blocking_no_leaves run function mob_dash:game/animals/spawn/pack/validate_and_summon
