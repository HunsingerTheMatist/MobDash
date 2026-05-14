# Auto-generated. Picks an animal to spawn at the current position via
#  cumulative-weight random selection, then runs that animal's summon function
# Used by: minecraft:birch_forest, minecraft:dark_forest, minecraft:old_growth_birch_forest (identical animal spawn weights)

execute store result score #pick_roll animal_weight run random value 0..1000000
scoreboard players operation #pick_roll animal_weight %= #forest_group_total animal_weight

execute if score #pick_roll animal_weight < #forest_group_chicken animal_weight run return run function mob_dash:game/animals/spawn/summon/chicken_pack4
scoreboard players operation #pick_roll animal_weight -= #forest_group_chicken animal_weight
execute if score #pick_roll animal_weight < #forest_group_cow animal_weight run return run function mob_dash:game/animals/spawn/summon/cow_pack4
scoreboard players operation #pick_roll animal_weight -= #forest_group_cow animal_weight
execute if score #pick_roll animal_weight < #forest_group_pig animal_weight run return run function mob_dash:game/animals/spawn/summon/pig_pack4
scoreboard players operation #pick_roll animal_weight -= #forest_group_pig animal_weight
execute if score #pick_roll animal_weight < #forest_group_sheep animal_weight run return run function mob_dash:game/animals/spawn/summon/sheep_pack4
scoreboard players operation #pick_roll animal_weight -= #forest_group_sheep animal_weight

return -19
