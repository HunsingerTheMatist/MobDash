# Remove temporary persistence from the current animal if nearby persistent animals exceed the allowed limit

# Exit early if no more animals need to lose temporary persistence
execute if score #persistent_animals_nearby md_state <= #persistent_animals_allowed md_state run return 1

tag @s remove md_temp_persistent
data modify entity @s PersistenceRequired set value false
scoreboard players remove #persistent_animals_nearby md_state 1

function mob_dash:game/animals/debug_glowing