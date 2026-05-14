# Auto-generated. Picks an animal to spawn at the current position via
#  cumulative-weight random selection, then runs that animal's summon function
# Used by: minecraft:forest

execute store result score #pick_roll animal_weight run random value 0..1000000
scoreboard players operation #pick_roll animal_weight %= #forest_total animal_weight

execute if score #pick_roll animal_weight < #forest_chicken animal_weight run return run function mob_dash:game/animals/spawn/summon/chicken_pack4
scoreboard players operation #pick_roll animal_weight -= #forest_chicken animal_weight
execute if score #pick_roll animal_weight < #forest_cow animal_weight run return run function mob_dash:game/animals/spawn/summon/cow_pack4
scoreboard players operation #pick_roll animal_weight -= #forest_cow animal_weight
execute if score #pick_roll animal_weight < #forest_pig animal_weight run return run function mob_dash:game/animals/spawn/summon/pig_pack4
scoreboard players operation #pick_roll animal_weight -= #forest_pig animal_weight
execute if score #pick_roll animal_weight < #forest_sheep animal_weight run return run function mob_dash:game/animals/spawn/summon/sheep_pack4
scoreboard players operation #pick_roll animal_weight -= #forest_sheep animal_weight
execute if score #pick_roll animal_weight < #forest_wolf animal_weight run return run function mob_dash:game/animals/spawn/summon/wolf_pack4
scoreboard players operation #pick_roll animal_weight -= #forest_wolf animal_weight

return -19
