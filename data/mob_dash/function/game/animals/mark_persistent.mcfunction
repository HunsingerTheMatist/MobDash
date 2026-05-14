# Set the current animal as persistent

data modify entity @s PersistenceRequired set value true

# Remove its interaction id since it's already persistent
function mob_dash:game/animals/interaction/remove_id

tag @s add md_persistent
scoreboard players reset @s md_despawn_timer
scoreboard players reset @s md_batch_id

execute unless score #debug_animal_handling md_animal_config matches 0 run function mob_dash:game/animals/debug/glowing
