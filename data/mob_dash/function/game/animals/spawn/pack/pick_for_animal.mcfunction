# Auto-generated. Pack-attempt dispatcher: re-runs the originally-picked
#  species' summon if the current biome still allows it. Callers (pack/
#  validate_and_summon) run this after a successful check_position on a
#  drifted pack attempt position
# Reads:
#   #picked_animal_id md_state   integer animal ID set by the initial summon
# Per-animal biome tags (#mob_dash:spawns/<animal>) gate by biome — if the
#  drifted position is in a biome where the locked species can't spawn, the
#  function falls through and returns -11 (counts as a wasted pack attempt,
#  matches vanilla)

execute if score #picked_animal_id md_state matches 1 if biome ~ ~ ~ #mob_dash:spawns/armadillo run return run function mob_dash:game/animals/spawn/summon/armadillo_pack1-2
execute if score #picked_animal_id md_state matches 2 if biome ~ ~ ~ #mob_dash:spawns/camel run return run function mob_dash:game/animals/spawn/summon/camel
execute if score #picked_animal_id md_state matches 3 if biome ~ ~ ~ #mob_dash:spawns/chicken run return run function mob_dash:game/animals/spawn/summon/chicken_pack4
execute if score #picked_animal_id md_state matches 4 if biome ~ ~ ~ #mob_dash:spawns/cow run return run function mob_dash:game/animals/spawn/summon/cow_pack4
execute if score #picked_animal_id md_state matches 5 if biome ~ ~ ~ #mob_dash:spawns/donkey run return run function mob_dash:game/animals/spawn/summon/donkey
execute if score #picked_animal_id md_state matches 6 if biome ~ ~ ~ #mob_dash:spawns/fox run return run function mob_dash:game/animals/spawn/summon/fox_pack2-4
execute if score #picked_animal_id md_state matches 7 if biome ~ ~ ~ #mob_dash:spawns/frog run return run function mob_dash:game/animals/spawn/summon/frog_pack2-5
execute if score #picked_animal_id md_state matches 8 if biome ~ ~ ~ #mob_dash:spawns/goat run return run function mob_dash:game/animals/spawn/summon/goat_pack1-3
execute if score #picked_animal_id md_state matches 9 if biome ~ ~ ~ #mob_dash:spawns/horse run return run function mob_dash:game/animals/spawn/summon/horse_pack2-6
execute if score #picked_animal_id md_state matches 10 if biome ~ ~ ~ #mob_dash:spawns/llama run return run function mob_dash:game/animals/spawn/summon/llama_pack4
execute if score #picked_animal_id md_state matches 11 if biome ~ ~ ~ #mob_dash:spawns/mooshroom run return run function mob_dash:game/animals/spawn/summon/mooshroom_pack4-8
execute if score #picked_animal_id md_state matches 12 if biome ~ ~ ~ #mob_dash:spawns/panda run return run function mob_dash:game/animals/spawn/summon/panda_pack1-2
execute if score #picked_animal_id md_state matches 13 if biome ~ ~ ~ #mob_dash:spawns/parrot run return run function mob_dash:game/animals/spawn/summon/parrot_pack1-2
execute if score #picked_animal_id md_state matches 14 if biome ~ ~ ~ #mob_dash:spawns/pig run return run function mob_dash:game/animals/spawn/summon/pig_pack1-2
execute if score #picked_animal_id md_state matches 15 if biome ~ ~ ~ #mob_dash:spawns/polar_bear run return run function mob_dash:game/animals/spawn/summon/polar_bear_pack1-2
execute if score #picked_animal_id md_state matches 16 if biome ~ ~ ~ #mob_dash:spawns/rabbit run return run function mob_dash:game/animals/spawn/summon/rabbit_pack2-3
execute if score #picked_animal_id md_state matches 17 if biome ~ ~ ~ #mob_dash:spawns/sheep run return run function mob_dash:game/animals/spawn/summon/sheep_pack2-4
execute if score #picked_animal_id md_state matches 18 if biome ~ ~ ~ #mob_dash:spawns/turtle run return run function mob_dash:game/animals/spawn/summon/turtle_pack2-5
execute if score #picked_animal_id md_state matches 19 if biome ~ ~ ~ #mob_dash:spawns/wolf run return run function mob_dash:game/animals/spawn/summon/wolf

return -11
