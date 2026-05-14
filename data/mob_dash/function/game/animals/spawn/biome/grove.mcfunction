# Auto-generated. Picks an animal to spawn at the current position via
#  cumulative-weight random selection, then runs that animal's summon function
# Used by: minecraft:grove

execute store result score #pick_roll animal_weight run random value 0..1000000
scoreboard players operation #pick_roll animal_weight %= #grove_total animal_weight

execute if score #pick_roll animal_weight < #grove_fox animal_weight run return run function mob_dash:game/animals/spawn/summon/fox_pack2-4
scoreboard players operation #pick_roll animal_weight -= #grove_fox animal_weight
execute if score #pick_roll animal_weight < #grove_rabbit animal_weight run return run function mob_dash:game/animals/spawn/summon/rabbit_pack2-3
scoreboard players operation #pick_roll animal_weight -= #grove_rabbit animal_weight
execute if score #pick_roll animal_weight < #grove_wolf animal_weight run return run function mob_dash:game/animals/spawn/summon/wolf
scoreboard players operation #pick_roll animal_weight -= #grove_wolf animal_weight

return -19
