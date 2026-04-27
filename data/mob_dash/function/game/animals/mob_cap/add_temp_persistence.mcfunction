# Add temporary persistence to the current animal if nearby persistent animals are below the allowed limit

# Exit early if no more animals need to get temporary persistence
execute if score @p[tag=md_current] md_player_cap >= #player_cap md_state run return 1

tag @s add md_temp_persistent
data modify entity @s PersistenceRequired set value true
scoreboard players add @p[tag=md_current] md_player_cap 1

function mob_dash:game/animals/debug_glowing