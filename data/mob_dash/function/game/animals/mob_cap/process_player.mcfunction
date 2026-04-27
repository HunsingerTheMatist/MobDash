# Process animals near the current player to artificially inflate the mob cap, adding or removing temporary persistence to reach $AnimalDespawningTargetCap

tag @s add md_current

# Check for structure-based persistence in case any new animals have appeared since preprocessing
execute as @e[type=#mob_dash:non_persistent_animals,distance=..160,tag=!md_structure_persistence_checked] run function mob_dash:game/animals/check_for_structure_persistence

# Count all animals nearby that currently don't count towards the cap
function mob_dash:game/animals/mob_cap/count_persistent_animals_nearby
scoreboard players operation #temp md_state = @s md_player_cap

# Remove temporary persistence from animals until the allowed limit is reached
execute if score @s md_player_cap > #player_cap md_state \
    as @e[type=#mob_dash:non_persistent_animals,distance=..160,tag=!md_has_or_is_passenger,tag=md_temp_persistent,sort=furthest] \
    run function mob_dash:game/animals/mob_cap/remove_temp_persistence

# Add temporary persistence to animals until the allowed limit is reached
execute if score @s md_player_cap < #player_cap md_state \
    as @e[type=#mob_dash:non_persistent_animals,distance=..160,tag=!md_persistent,tag=!md_temp_persistent,tag=!md_has_or_is_passenger,sort=nearest] \
    run function mob_dash:game/animals/mob_cap/add_temp_persistence

execute unless score #debug_animal_handling md_animal_config matches 0 run \
    tellraw @a [{text:"Persistent animals near "},{selector:"@s"},{text:": "},{score:{objective:md_state, name:"#temp"},color:blue},{text:"/"},{score:{objective:md_state, name:"#player_cap"}}, \
    {text:" -> "}, {score:{objective:md_player_cap, name:"@s"},color:blue},{text:"/"},{score:{objective:md_state, name:"#player_cap"}}]

tag @s remove md_current