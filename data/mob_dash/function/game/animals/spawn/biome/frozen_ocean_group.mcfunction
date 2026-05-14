# Auto-generated. Picks an animal to spawn at the current position via
#  cumulative-weight random selection, then runs that animal's summon function
# Used by: minecraft:deep_frozen_ocean, minecraft:frozen_ocean (identical animal spawn weights)

execute store result score #pick_roll animal_weight run random value 0..1000000
scoreboard players operation #pick_roll animal_weight %= #frozen_ocean_group_total animal_weight

execute if score #pick_roll animal_weight < #frozen_ocean_group_polar_bear animal_weight run return run function mob_dash:game/animals/spawn/summon/polar_bear_pack1-2
scoreboard players operation #pick_roll animal_weight -= #frozen_ocean_group_polar_bear animal_weight

return -19
