# Auto-generated. Picks an animal to spawn at the current position via
#  cumulative-weight random selection, then runs that animal's summon function
# Used by: minecraft:cherry_grove

execute store result score #pick_roll animal_weight run random value 0..1000000
scoreboard players operation #pick_roll animal_weight %= #cherry_grove_total animal_weight

execute if score #pick_roll animal_weight < #cherry_grove_pig animal_weight run return run function mob_dash:game/animals/spawn/summon/pig_pack1-2
scoreboard players operation #pick_roll animal_weight -= #cherry_grove_pig animal_weight
execute if score #pick_roll animal_weight < #cherry_grove_rabbit animal_weight run return run function mob_dash:game/animals/spawn/summon/rabbit_pack2-6
scoreboard players operation #pick_roll animal_weight -= #cherry_grove_rabbit animal_weight
execute if score #pick_roll animal_weight < #cherry_grove_sheep animal_weight run return run function mob_dash:game/animals/spawn/summon/sheep_pack2-4
scoreboard players operation #pick_roll animal_weight -= #cherry_grove_sheep animal_weight

return -19
