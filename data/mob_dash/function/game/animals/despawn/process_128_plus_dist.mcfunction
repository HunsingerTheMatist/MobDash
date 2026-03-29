# Tags a portion of animals that are 128+ blocks from any player for despawn
# Proportion of animals that are targeted
# = ($AnimalDespawnChance_Base / $AnimalTotalChance_Base) * ($AnimalDespawnChance_128_plus / $AnimalTotalChance_128_plus)

scoreboard players add #despawn_iter_128_plus md_state 1

# Reset the iterator back to 1 if it goes above the iteration limit
execute if score #despawn_iter_128_plus md_state > $AnimalTotalChance_128_plus md_animal_config run scoreboard players set #despawn_iter_128_plus md_state 1

# Debug message documenting that the selected mob was not chosen for despawn
execute unless score #debug_animal_handling md_animal_config matches 0 \
    if score #despawn_iter_128_plus md_state > $AnimalDespawnChance_128_plus md_animal_config run \
    tellraw @a [{text:"Batch "},{score:{objective:md_state,name:"#curr_despawn_batch"}},{text:": "},{text:"Not Despawning",color:green}, \
    {text:" (128+ "},{score:{objective:md_state,name:"#nondespawn_chance_128_plus"},color:blue},{text:"%) "},{selector:"@s"}]

# Exit early if the iterator is above the despawn chance
execute if score #despawn_iter_128_plus md_state > $AnimalDespawnChance_128_plus md_animal_config run return 1

# Tag the mob for despawn since the iterator is <= the despawn chance
function mob_dash:game/animals/despawn/tag_for_despawn

# Debug message documenting that the selected mob was chosen for despawn
execute unless score #debug_animal_handling md_animal_config matches 0 run \
    tellraw @a [{text:"Batch "},{score:{objective:md_state,name:"#curr_despawn_batch"}},{text:": "},{text:"Despawning",color:red}, \
    {text:" (128+ "},{score:{objective:md_state,name:"#despawn_chance_128_plus"},color:blue},{text:"%) "},{selector:"@s"}]