# Auto-generated. Picks an animal to spawn at the current position via
#  cumulative-weight random selection, then runs that animal's summon function
# Used by: minecraft:frozen_peaks, minecraft:jagged_peaks (identical animal spawn weights)

execute store result score #pick_roll animal_weight run random value 0..1000000
scoreboard players operation #pick_roll animal_weight %= #peaks_group_total animal_weight

execute if score #pick_roll animal_weight < #peaks_group_goat animal_weight run return run function mob_dash:game/animals/spawn/summon/goat_pack1-3
scoreboard players operation #pick_roll animal_weight -= #peaks_group_goat animal_weight

return -19
