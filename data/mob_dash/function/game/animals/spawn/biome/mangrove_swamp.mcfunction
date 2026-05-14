# Auto-generated. Picks an animal to spawn at the current position via
#  cumulative-weight random selection, then runs that animal's summon function
# Used by: minecraft:mangrove_swamp

execute store result score #pick_roll animal_weight run random value 0..1000000
scoreboard players operation #pick_roll animal_weight %= #mangrove_swamp_total animal_weight

execute if score #pick_roll animal_weight < #mangrove_swamp_frog animal_weight run return run function mob_dash:game/animals/spawn/summon/frog_pack2-5
scoreboard players operation #pick_roll animal_weight -= #mangrove_swamp_frog animal_weight

return -19
