# Auto-generated. Picks an animal to spawn at the current position via
#  cumulative-weight random selection, then runs that animal's summon function
# Used by: minecraft:snowy_slopes

execute store result score #pick_roll animal_weight run random value 0..1000000
scoreboard players operation #pick_roll animal_weight %= #snowy_slopes_total animal_weight

execute if score #pick_roll animal_weight < #snowy_slopes_goat animal_weight run return run function mob_dash:game/animals/spawn/summon/goat_pack1-3
scoreboard players operation #pick_roll animal_weight -= #snowy_slopes_goat animal_weight
execute if score #pick_roll animal_weight < #snowy_slopes_rabbit animal_weight run return run function mob_dash:game/animals/spawn/summon/rabbit_pack2-3
scoreboard players operation #pick_roll animal_weight -= #snowy_slopes_rabbit animal_weight

return -19
