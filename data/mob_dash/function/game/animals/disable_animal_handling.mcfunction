# Disables animal handling logic

# Only run on falling edge of $UseAnimalDespawning (ie: right when it turns off)
execute if score #prev_use_animal_despawning md_state matches 0 run return 1
scoreboard players set #prev_use_animal_despawning md_state 0

advancement grant @a only mob_dash:interact_with_animal