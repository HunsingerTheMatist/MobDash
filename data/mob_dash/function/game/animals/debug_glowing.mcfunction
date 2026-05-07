# Updates debug glow visualization for the current animal
# When animal debug mode is enabled, the animal will glow and be assigned a color:
# - Blue: persistent animals
# - Purple: animals batched for despawn
# - Green: temporarily persistent animals

execute if score #debug_animal_handling md_animal_config matches 0 run return 1

execute if entity @s[tag=!md_persistent,tag=!md_temp_persistent,tag=!md_despawn_batched] run return run data modify entity @s Glowing set value false

data modify entity @s Glowing set value true

execute if entity @s[tag=md_persistent] run return run team join blue @s
execute if entity @s[tag=md_despawn_batched] run return run team join purple @s
execute if entity @s[tag=md_temp_persistent] run return run team join green @s
