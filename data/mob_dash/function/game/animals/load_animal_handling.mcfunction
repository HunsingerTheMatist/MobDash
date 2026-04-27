# On datapack load

# Scoreboards for animal despawning
scoreboard objectives add md_animal_config dummy "Mob Dash Animal Configs"
scoreboard objectives add md_batch_idx dummy
scoreboard objectives add md_player_cap dummy
scoreboard objectives add md_id dummy
scoreboard objectives add md_id_0 dummy
scoreboard objectives add md_id_1 dummy
scoreboard objectives add md_id_2 dummy
scoreboard objectives add md_id_3 dummy
scoreboard objectives add md_id_4 dummy
scoreboard objectives add md_id_5 dummy
scoreboard objectives add md_id_6 dummy
scoreboard objectives add md_id_7 dummy
scoreboard objectives add md_id_8 dummy

# Set default configs
execute unless score $UseAnimalDespawning md_animal_config matches 0..1 run scoreboard players set $UseAnimalDespawning md_animal_config 1
execute unless score $AnimalDespawningTargetCap md_animal_config matches 1.. run scoreboard players set $AnimalDespawningTargetCap md_animal_config 60

execute unless score $AnimalDespawnChanceReduction_HalfCap md_animal_config matches 0.. run scoreboard players set $AnimalDespawnChanceReduction_HalfCap md_animal_config 3
execute unless score $AnimalDespawnChanceReduction_ThirdCap md_animal_config matches 0.. run scoreboard players set $AnimalDespawnChanceReduction_ThirdCap md_animal_config 6

execute unless score $AnimalDespawnChance_Base md_animal_config matches 0.. run scoreboard players set $AnimalDespawnChance_Base md_animal_config 1
execute unless score $AnimalTotalChance_Base md_animal_config matches 0.. run scoreboard players set $AnimalTotalChance_Base md_animal_config 3
execute unless score $AnimalDespawnChance_0_63 md_animal_config matches 0.. run scoreboard players set $AnimalDespawnChance_0_63 md_animal_config 0
execute unless score $AnimalTotalChance_0_63 md_animal_config matches 0.. run scoreboard players set $AnimalTotalChance_0_63 md_animal_config 0
execute unless score $AnimalDespawnChance_64_127 md_animal_config matches 0.. run scoreboard players set $AnimalDespawnChance_64_127 md_animal_config 1
execute unless score $AnimalTotalChance_64_127 md_animal_config matches 0.. run scoreboard players set $AnimalTotalChance_64_127 md_animal_config 2
execute unless score $AnimalDespawnChance_128_plus md_animal_config matches 0.. run scoreboard players set $AnimalDespawnChance_128_plus md_animal_config 1
execute unless score $AnimalTotalChance_128_plus md_animal_config matches 0.. run scoreboard players set $AnimalTotalChance_128_plus md_animal_config 1

# Debug mode for animal handling logic
scoreboard players set #debug_animal_handling md_animal_config 0

# Set interaction logic id
execute unless score #next_id md_state matches 1.. run scoreboard players set #next_id md_state 1