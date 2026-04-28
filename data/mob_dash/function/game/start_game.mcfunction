# Starts the game

execute unless dimension mob_dash:md_markers in mob_dash:md_markers positioned 0 0 0 run return run function mob_dash:game/start_game

execute in overworld run worldborder set 50000

gamerule advance_time true
gamerule advance_weather true
gamerule spawn_mobs true
time of overworld set day

tellraw @a "\n\n\n\n\n"

execute as @a run function mob_dash:game/player/player_game_setup

scoreboard players set $GameState md_state 2
function mob_dash:game/player/update_game_index

function mob_dash:game/reset_marker_data

scoreboard players set $TargetCount md_state 0
scoreboard players set $TotalMobsSelected md_state 0
scoreboard players set $GameTick md_state 0
scoreboard players set $ActionBarCache md_state 0

# Set appropriate difficulty
execute if score $GameDifficulty md_state matches 1 run difficulty easy
execute if score $GameDifficulty md_state matches 2 run difficulty normal
execute if score $GameDifficulty md_state matches 3 run difficulty hard

function mob_dash:game/sidebar/update_sidebar_scores

execute unless score $Bounties md_setting matches 0 run function mob_dash:game/bounty/roll_bounty_cooldown
execute unless score $Bounties md_setting matches 0 run function mob_dash:game/bounty/setup_sidebar
execute unless score $Bounties md_setting matches 0 run function mob_dash:game/bounty/display_no_bounty

execute if score $EndTick md_state matches 1.. run function mob_dash:game/setup_timer_bar