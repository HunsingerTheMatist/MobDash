# Print result of the most recent spawn attempt. Callers: 'validate_and_summon',
#  'pack/validate_and_summon'. Runs at the resolved + snapped spawn position,
#  so ~ ~ ~ is the position to display
# Reads:
#   #spawn_result md_state           reason code from 'check_position' chain (see 'check_position' header)
#   #spawn_attempts / #spawn_successes md_state  cumulative counters since last 'hard_reset'
#   #doing_pack_spawn md_state       0 = initial spawn, 1 = pack repeat — drives the [Spawn] / [Pack] prefix
#   #picked_animal_id md_state       integer animal ID written by the matching summon variant; decoded below into Debug.AnimalName

# Capture spawn position via an ephemeral marker (lives only within this
#  function — summoned, read, killed). Pos NBT is the only way to get the
#  current execution position into storage as numbers
summon marker ~ ~ ~ {UUID: [I;1615826161,-1372961304,-1484384556,1628504363]}
execute store result storage mob_dash:data Debug.MacroArgs.x int 1 run data get entity 604f8cf1-ae2a-45e8-a786-16d46111012b Pos[0] 1
execute store result storage mob_dash:data Debug.MacroArgs.y int 1 run data get entity 604f8cf1-ae2a-45e8-a786-16d46111012b Pos[1] 1
execute store result storage mob_dash:data Debug.MacroArgs.z int 1 run data get entity 604f8cf1-ae2a-45e8-a786-16d46111012b Pos[2] 1
kill 604f8cf1-ae2a-45e8-a786-16d46111012b

# Pick the line prefix from #doing_pack_spawn
execute if score #doing_pack_spawn md_state matches 0 run data modify storage mob_dash:data Debug.Prefix set value "[Spawn] "
execute if score #doing_pack_spawn md_state matches 1 run data modify storage mob_dash:data Debug.Prefix set value "  - [Pack] "

# Decode #picked_animal_id into Debug.AnimalName. ID -1 or any unmatched value
#  falls back to "None" — covers the "no animal picked" case where the summon
#  never fired
function mob_dash:game/animals/debug/decode_animal_name

# Decode #spawn_result into Debug.Reason. Codes are grouped by category:
#  -10..-19 = biome reasons, -20..-29 = position reasons. Within each group,
#  the high end (-18, -19) holds "should never happen" internal errors
# Biome:
execute if score #spawn_result md_state matches -10 run data modify storage mob_dash:data Debug.Reason set value "non-animal biome"
execute if score #spawn_result md_state matches -11 run data modify storage mob_dash:data Debug.Reason set value "invalid biome"
execute if score #spawn_result md_state matches -18 run data modify storage mob_dash:data Debug.Reason set value "NO BIOME MATCH!"
execute if score #spawn_result md_state matches -19 run data modify storage mob_dash:data Debug.Reason set value "BIOME PICKER FALL-THROUGH!"
# Position:
execute if score #spawn_result md_state matches -20 run data modify storage mob_dash:data Debug.Reason set value "block collision"
execute if score #spawn_result md_state matches -21 run data modify storage mob_dash:data Debug.Reason set value "block under invalid"
execute if score #spawn_result md_state matches -22 run data modify storage mob_dash:data Debug.Reason set value "hitbox collision"
execute if score #spawn_result md_state matches -23 run data modify storage mob_dash:data Debug.Reason set value "player within 24"
execute if score #spawn_result md_state matches -25 run data modify storage mob_dash:data Debug.Reason set value "animal too close"
execute if score #spawn_result md_state matches -24 run data modify storage mob_dash:data Debug.Reason set value "same location"

function mob_dash:game/animals/debug/tp_macro with storage mob_dash:data Debug.MacroArgs

execute if score #spawn_result md_state matches 1 run return run tellraw @a \
           ["",{storage:"mob_dash:data", nbt:Debug.Prefix, interpret:true, color:light_purple}, {text:"Success", color:green},              {text:" at "}, {storage:"mob_dash:data", nbt:Debug.AnimalSpawn, interpret:true}, {text:": "}, {storage:"mob_dash:data", nbt:Debug.AnimalName, interpret:true, color:yellow}]
execute if score #spawn_result md_state matches 0 run return run tellraw @a \
           ["",{storage:"mob_dash:data", nbt:Debug.Prefix, interpret:true, color:light_purple}, {text:"Fail (INTERNAL ERROR!)", color:red}, {text:" at "}, {storage:"mob_dash:data", nbt:Debug.AnimalSpawn, interpret:true}, {text:": "}, {storage:"mob_dash:data", nbt:Debug.AnimalName, interpret:true, color:red}]
tellraw @a ["",{storage:"mob_dash:data", nbt:Debug.Prefix, interpret:true, color:light_purple}, {text:"Fail", color:red},                   {text:" at "}, {storage:"mob_dash:data", nbt:Debug.AnimalSpawn, interpret:true}, {text:": "}, {storage:"mob_dash:data", nbt:Debug.AnimalName, interpret:true, color:red}, {text:" (", color:blue}, {storage:"mob_dash:data", nbt:Debug.Reason, interpret:true, color:blue, extra:[")"]}]
