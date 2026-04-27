# Remove temporary persistence from the current animal if nearby persistent animals exceed the allowed limit

# Exit early if no more animals need to lose temporary persistence
execute if score @p[tag=md_current] md_player_cap <= #player_cap md_state run return 1

tag @s remove md_temp_persistent
data modify entity @s PersistenceRequired set value false
scoreboard players remove @p[tag=md_current] md_player_cap 1

function mob_dash:game/animals/debug_glowing