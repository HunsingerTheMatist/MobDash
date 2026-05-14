# Auto-generated. Routes to the per-biome animal picker based on the biome at
#  the current executor position. Biomes with identical animal spawn lists share
#  a picker — for those, dispatch is via the matching
#  #mob_dash:animal_spawn_groups/<canonical> tag rather than per-biome checks
# Runs at the spawn position

execute if biome ~ ~ ~ #mob_dash:animal_spawn_groups/badlands_group run return run function mob_dash:game/animals/spawn/biome/badlands_group
execute if biome ~ ~ ~ #mob_dash:animal_spawn_groups/forest_group run return run function mob_dash:game/animals/spawn/biome/forest_group
execute if biome ~ ~ ~ #mob_dash:animal_spawn_groups/frozen_ocean_group run return run function mob_dash:game/animals/spawn/biome/frozen_ocean_group
execute if biome ~ ~ ~ #mob_dash:animal_spawn_groups/ice_spikes_group run return run function mob_dash:game/animals/spawn/biome/ice_spikes_group
execute if biome ~ ~ ~ #mob_dash:animal_spawn_groups/peaks_group run return run function mob_dash:game/animals/spawn/biome/peaks_group
execute if biome ~ ~ ~ #mob_dash:animal_spawn_groups/plains_group run return run function mob_dash:game/animals/spawn/biome/plains_group
execute if biome ~ ~ ~ #mob_dash:animal_spawn_groups/savanna_group run return run function mob_dash:game/animals/spawn/biome/savanna_group
execute if biome ~ ~ ~ #mob_dash:animal_spawn_groups/taiga_group run return run function mob_dash:game/animals/spawn/biome/taiga_group
execute if biome ~ ~ ~ #mob_dash:animal_spawn_groups/windswept_group run return run function mob_dash:game/animals/spawn/biome/windswept_group

execute if biome ~ ~ ~ minecraft:bamboo_jungle run return run function mob_dash:game/animals/spawn/biome/bamboo_jungle
execute if biome ~ ~ ~ minecraft:beach run return run function mob_dash:game/animals/spawn/biome/beach
execute if biome ~ ~ ~ minecraft:cherry_grove run return run function mob_dash:game/animals/spawn/biome/cherry_grove
execute if biome ~ ~ ~ minecraft:desert run return run function mob_dash:game/animals/spawn/biome/desert
execute if biome ~ ~ ~ minecraft:flower_forest run return run function mob_dash:game/animals/spawn/biome/flower_forest
execute if biome ~ ~ ~ minecraft:forest run return run function mob_dash:game/animals/spawn/biome/forest
execute if biome ~ ~ ~ minecraft:grove run return run function mob_dash:game/animals/spawn/biome/grove
execute if biome ~ ~ ~ minecraft:jungle run return run function mob_dash:game/animals/spawn/biome/jungle
execute if biome ~ ~ ~ minecraft:mangrove_swamp run return run function mob_dash:game/animals/spawn/biome/mangrove_swamp
execute if biome ~ ~ ~ minecraft:meadow run return run function mob_dash:game/animals/spawn/biome/meadow
execute if biome ~ ~ ~ minecraft:mushroom_fields run return run function mob_dash:game/animals/spawn/biome/mushroom_fields
execute if biome ~ ~ ~ minecraft:savanna_plateau run return run function mob_dash:game/animals/spawn/biome/savanna_plateau
execute if biome ~ ~ ~ minecraft:snowy_slopes run return run function mob_dash:game/animals/spawn/biome/snowy_slopes
execute if biome ~ ~ ~ minecraft:sparse_jungle run return run function mob_dash:game/animals/spawn/biome/sparse_jungle
execute if biome ~ ~ ~ minecraft:swamp run return run function mob_dash:game/animals/spawn/biome/swamp
execute if biome ~ ~ ~ minecraft:wooded_badlands run return run function mob_dash:game/animals/spawn/biome/wooded_badlands

return -18
