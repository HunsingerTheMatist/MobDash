# Get despawn & non-despawn chances as percentages

execute if score #despawn_chance md_state matches ..-1 run scoreboard players set #despawn_chance md_state 0
scoreboard players operation #despawn_chance_percentage md_state = #despawn_chance md_state
scoreboard players operation #despawn_chance_percentage md_state *= 100 md_const
scoreboard players operation #despawn_chance_percentage md_state /= #total_despawn_chance md_state

scoreboard players set #nondespawn_chance_percentage md_state 100
scoreboard players operation #nondespawn_chance_percentage md_state -= #despawn_chance_percentage md_state