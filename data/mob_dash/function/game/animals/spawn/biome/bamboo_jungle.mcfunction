# Auto-generated. Picks an animal to spawn at the current position via
#  cumulative-weight random selection, then runs that animal's summon function
# Used by: minecraft:bamboo_jungle

execute store result score #pick_roll animal_weight run random value 0..1000000
scoreboard players operation #pick_roll animal_weight %= #bamboo_jungle_total animal_weight

execute if score #pick_roll animal_weight < #bamboo_jungle_chicken animal_weight run return run function mob_dash:game/animals/spawn/summon/chicken_pack4
scoreboard players operation #pick_roll animal_weight -= #bamboo_jungle_chicken animal_weight
execute if score #pick_roll animal_weight < #bamboo_jungle_cow animal_weight run return run function mob_dash:game/animals/spawn/summon/cow_pack4
scoreboard players operation #pick_roll animal_weight -= #bamboo_jungle_cow animal_weight
execute if score #pick_roll animal_weight < #bamboo_jungle_panda animal_weight run return run function mob_dash:game/animals/spawn/summon/panda_pack1-2
scoreboard players operation #pick_roll animal_weight -= #bamboo_jungle_panda animal_weight
execute if score #pick_roll animal_weight < #bamboo_jungle_parrot animal_weight run return run function mob_dash:game/animals/spawn/summon/parrot_pack1-2
scoreboard players operation #pick_roll animal_weight -= #bamboo_jungle_parrot animal_weight
execute if score #pick_roll animal_weight < #bamboo_jungle_pig animal_weight run return run function mob_dash:game/animals/spawn/summon/pig_pack4
scoreboard players operation #pick_roll animal_weight -= #bamboo_jungle_pig animal_weight
execute if score #pick_roll animal_weight < #bamboo_jungle_sheep animal_weight run return run function mob_dash:game/animals/spawn/summon/sheep_pack4
scoreboard players operation #pick_roll animal_weight -= #bamboo_jungle_sheep animal_weight

return -19
