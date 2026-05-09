# Runs for every player whose game index does not match the currently tracked GameIndex
# This includes new players and players who have left & rejoined after the GameState has changed

scoreboard players operation #index_delta md_state = $GameIndex md_state
scoreboard players operation #index_delta md_state -= @s md_game_idx
scoreboard players operation @s md_game_idx = $GameIndex md_state

# If the GameState is 0 or 1 they should be tp-ed & added to a random team if necessary
# If the GameState is 2 they should always be put in spec mode (they were not there when the pre-game started)
# If the GameState is 3 and the index_delta is 1 then they are in the game but start_game did not process them
# If the GameState is 3 and the index_delta is not 1 then they should be put in spec mode (same reason as for GameState 2)
# If the GameState is 4 they should always be put in spec mode (everyone is in spec), but only tp-ed if their index_delta is 10 or above (they left from a previous game)

execute if score $GameState md_state matches 0..1 run return run function mob_dash:game/player/player_menu_setup
execute if score $GameState md_state matches 2 run return run function mob_dash:game/player/put_player_in_spec
execute if score $GameState md_state matches 3 if score #index_delta md_state matches 1 run return run function mob_dash:game/player/player_game_setup
execute if score $GameState md_state matches 3 unless score #index_delta md_state matches 1 run return run function mob_dash:game/player/put_player_in_spec
execute if score $GameState md_state matches 4 if score #index_delta md_state matches 10.. in overworld run tp @s @n[distance=0..,type=marker,tag=md_game_spawn]
execute if score $GameState md_state matches 4 run return run gamemode spectator @s
