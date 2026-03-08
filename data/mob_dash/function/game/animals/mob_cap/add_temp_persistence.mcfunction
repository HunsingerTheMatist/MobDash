# Add temporary persistence to the current animal if nearby persistent animals are below the allowed limit

# Exit early if no more animals need to get temporary persistence
execute if score #persistent_animals_nearby md_state >= #persistent_animals_allowed md_state run return 1

tag @s add md_temp_persistent
data modify entity @s PersistenceRequired set value true
scoreboard players add #persistent_animals_nearby md_state 1

function mob_dash:game/animals/debug_glowing