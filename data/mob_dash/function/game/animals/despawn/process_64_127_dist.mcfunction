# Tags a portion of animals that are 64-127 blocks from any player for despawn
# Proportion of animals that are targeted
# = ($AnimalDespawnChance_Base / $AnimalTotalChance_Base) * ($AnimalDespawnChance_64_127 / $AnimalTotalChance_64_127)

scoreboard players add #despawn_iter_64_127 md_state 1

# Reset the iterator back to 1 if it goes above the iteration limit
execute if score #despawn_iter_64_127 md_state > $AnimalTotalChance_64_127 md_state run scoreboard players set #despawn_iter_64_127 md_state 1

# Debug message documenting that the selected mob was not chosen for despawn
execute if score #despawn_iter_64_127 md_state > $AnimalDespawnChance_64_127 md_state \
    unless score #debug_animal_handling md_state matches 0 run \
    tellraw @a [{text:"Batch "},{score:{objective:md_state,name:"#curr_despawn_batch"}},{text:": "},{text:"Not Despawning",color:green}, \
    {text:" (64-127 "},{score:{objective:md_state,name:"#nondespawn_chance_64_127"},color:blue},{text:"%) "},{selector:"@s"}]

# Exit early if the iterator is above the despawn chance
execute if score #despawn_iter_64_127 md_state > $AnimalDespawnChance_64_127 md_state run return 1

# Tag the mob for despawn since the iterator is <= the despawn chance
function mob_dash:game/animals/despawn/tag_for_despawn

# Debug message documenting that the selected mob was chosen for despawn
execute unless score #debug_animal_handling md_state matches 0 run \
    tellraw @a [{text:"Batch "},{score:{objective:md_state,name:"#curr_despawn_batch"}},{text:": "},{text:"Despawning",color:red}, \
    {text:" (64-127 "},{score:{objective:md_state,name:"#despawn_chance_64_127"},color:blue},{text:"%) "},{selector:"@s"}]
