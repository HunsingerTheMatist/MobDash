# Runs once at the start of the menu

# Keep the game stalled until starting
gamerule advance_time false
gamerule advance_weather false
gamerule spawn_mobs false
time of overworld set noon

# Stores the difficulty for later to be set when starting the game
execute store result score #temp md_state run difficulty
scoreboard players operation $GameDifficulty md_state = #temp md_state
difficulty peaceful

scoreboard players set $GameState md_state 1
function mob_dash:global/update_game_index
