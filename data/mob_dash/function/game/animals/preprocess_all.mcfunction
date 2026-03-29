# Preprocess all animal mobs, marking relevant ones as persistent, putting others into batches for despawn, and putting players into batches for higher mob cap

# Mark animals as permanently persistent:
# - Mob types that should always be persistent (ex: bee, allay)
# - All baby mobs
# - All mobs spawned as persistent in structures (ex: cows in villages)
execute as @e[type=#mob_dash:persistent_animals,tag=!md_persistent] run function mob_dash:game/animals/mark_persistent
execute as @e[type=#mob_dash:non_persistent_animals,tag=!md_persistent,predicate=mob_dash:is_baby] run function mob_dash:game/animals/mark_persistent
execute as @e[type=#mob_dash:non_persistent_animals,tag=!md_structure_persistence_checked] run function mob_dash:game/animals/check_for_structure_persistence

# Put a portion of all eligible despawnable animals into batches to process despawn logic later in the tick
execute as @e[type=#mob_dash:despawnable_animals,tag=!md_persistent,tag=!md_despawn_batched,tag=md_despawn_eligible,sort=random] run function mob_dash:game/animals/batch_animal

# Put all active players in batches to process mob cap logic later in the tick
execute as @a[gamemode=!spectator] run function mob_dash:game/animals/batch_player

execute unless score #debug_animal_handling md_animal_config matches 0 store result score #temp md_state if entity @e[type=#mob_dash:despawnable_animals,tag=md_despawn_batched]
execute unless score #debug_animal_handling md_animal_config matches 0 store result score #temp2 md_state if entity @e[type=#mob_dash:despawnable_animals,tag=!md_despawn_batched]
execute unless score #debug_animal_handling md_animal_config matches 0 run tellraw @a [{text:"PREPROCESSING: "},{score:{objective:md_state,name:"#temp"},color:blue},{text:"/"},{score:{objective:md_state,name:"#temp2"}},{text:" animals batched with "}, \
    {score:{objective:md_animal_config,name:"$AnimalDespawnChance_Base"}},{text:"/"},{score:{objective:md_animal_config,name:"$AnimalTotalChance_Base"}},{text:" chance"}]

# Tag any new animals as eligible for despawn in the next cycle
# This is to allow all newly spawned mobs to exist for at least 400 ticks before they can be despawned
tag @e[type=#mob_dash:despawnable_animals,tag=!md_persistent,tag=!md_despawn_eligible] add md_despawn_eligible