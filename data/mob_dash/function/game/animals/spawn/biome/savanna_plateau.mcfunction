# Auto-generated. Picks an animal to spawn at the current position via
#  cumulative-weight random selection, then runs that animal's summon function
# Used by: minecraft:savanna_plateau

execute store result score #pick_roll animal_weight run random value 0..1000000
scoreboard players operation #pick_roll animal_weight %= #savanna_plateau_total animal_weight

execute if score #pick_roll animal_weight < #savanna_plateau_armadillo animal_weight run return run function mob_dash:game/animals/spawn/summon/armadillo_pack2-3
scoreboard players operation #pick_roll animal_weight -= #savanna_plateau_armadillo animal_weight
execute if score #pick_roll animal_weight < #savanna_plateau_chicken animal_weight run return run function mob_dash:game/animals/spawn/summon/chicken_pack4
scoreboard players operation #pick_roll animal_weight -= #savanna_plateau_chicken animal_weight
execute if score #pick_roll animal_weight < #savanna_plateau_cow animal_weight run return run function mob_dash:game/animals/spawn/summon/cow_pack4
scoreboard players operation #pick_roll animal_weight -= #savanna_plateau_cow animal_weight
execute if score #pick_roll animal_weight < #savanna_plateau_donkey animal_weight run return run function mob_dash:game/animals/spawn/summon/donkey
scoreboard players operation #pick_roll animal_weight -= #savanna_plateau_donkey animal_weight
execute if score #pick_roll animal_weight < #savanna_plateau_horse animal_weight run return run function mob_dash:game/animals/spawn/summon/horse_pack2-6
scoreboard players operation #pick_roll animal_weight -= #savanna_plateau_horse animal_weight
execute if score #pick_roll animal_weight < #savanna_plateau_llama animal_weight run return run function mob_dash:game/animals/spawn/summon/llama_pack4
scoreboard players operation #pick_roll animal_weight -= #savanna_plateau_llama animal_weight
execute if score #pick_roll animal_weight < #savanna_plateau_pig animal_weight run return run function mob_dash:game/animals/spawn/summon/pig_pack4
scoreboard players operation #pick_roll animal_weight -= #savanna_plateau_pig animal_weight
execute if score #pick_roll animal_weight < #savanna_plateau_sheep animal_weight run return run function mob_dash:game/animals/spawn/summon/sheep_pack4
scoreboard players operation #pick_roll animal_weight -= #savanna_plateau_sheep animal_weight
execute if score #pick_roll animal_weight < #savanna_plateau_wolf animal_weight run return run function mob_dash:game/animals/spawn/summon/wolf_pack4-8
scoreboard players operation #pick_roll animal_weight -= #savanna_plateau_wolf animal_weight

return -19
