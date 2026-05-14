# Auto-generated. Picks an animal to spawn at the current position via
#  cumulative-weight random selection, then runs that animal's summon function
# Used by: minecraft:meadow

execute store result score #pick_roll animal_weight run random value 0..1000000
scoreboard players operation #pick_roll animal_weight %= #meadow_total animal_weight

execute if score #pick_roll animal_weight < #meadow_donkey animal_weight run return run function mob_dash:game/animals/spawn/summon/donkey_pack1-2
scoreboard players operation #pick_roll animal_weight -= #meadow_donkey animal_weight
execute if score #pick_roll animal_weight < #meadow_rabbit animal_weight run return run function mob_dash:game/animals/spawn/summon/rabbit_pack2-6
scoreboard players operation #pick_roll animal_weight -= #meadow_rabbit animal_weight
execute if score #pick_roll animal_weight < #meadow_sheep animal_weight run return run function mob_dash:game/animals/spawn/summon/sheep_pack2-4
scoreboard players operation #pick_roll animal_weight -= #meadow_sheep animal_weight

return -19
