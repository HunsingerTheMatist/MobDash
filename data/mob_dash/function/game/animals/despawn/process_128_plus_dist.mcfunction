# Tags a portion of animals that are 128+ blocks from any player for despawn
# Proportion of animals that are targeted
# = ($AnimalDespawnChance_Base / $AnimalTotalChance_Base) * ($AnimalDespawnChance_128_plus / $AnimalTotalChance_128_plus)

scoreboard players add #despawn_iter_128_plus md_state 1

scoreboard players operation #total_despawn_chance md_state = $AnimalTotalChance_128_plus md_animal_config
scoreboard players operation #total_despawn_chance md_state *= 10 md_const

# Reset the iterator back to 1 if it goes above the iteration limit
execute if score #despawn_iter_128_plus md_state > #total_despawn_chance md_state run scoreboard players set #despawn_iter_128_plus md_state 1

scoreboard players operation #despawn_chance md_state = $AnimalDespawnChance_128_plus md_animal_config
scoreboard players operation #despawn_chance md_state *= 10 md_const
function mob_dash:game/animals/despawn/calculate_despawn_chance
execute unless score #debug_animal_handling md_animal_config matches 0 run function mob_dash:game/animals/despawn/debug_despawn_chances
execute store result score #should_despawn md_state unless score #despawn_iter_128_plus md_state > #despawn_chance md_state

# Debug message documenting that the selected mob was not chosen for despawn
execute if score #should_despawn md_state matches 0 \
    unless score #debug_animal_handling md_animal_config matches 0 run \
    tellraw @a [{text:"Batch "},{score:{objective:md_state,name:"#curr_despawn_batch"}},{text:": "},{text:"Not Despawning",color:green}, \
    {text:" (128+ "},{score:{objective:md_state,name:"#nondespawn_chance_percentage"},color:blue},{text:"%) "},{selector:"@s"}]

# Exit early if the mob should not despawn
execute if score #should_despawn md_state matches 0 run return 1

# Tag the mob for despawn since the iterator is <= the despawn chance
function mob_dash:game/animals/despawn/tag_for_despawn

# Debug message documenting that the selected mob was chosen for despawn
execute unless score #debug_animal_handling md_animal_config matches 0 run \
    tellraw @a [{text:"Batch "},{score:{objective:md_state,name:"#curr_despawn_batch"}},{text:": "},{text:"Despawning",color:red}, \
    {text:" (128+ "},{score:{objective:md_state,name:"#despawn_chance_percentage"},color:blue},{text:"%) "},{selector:"@s"}]