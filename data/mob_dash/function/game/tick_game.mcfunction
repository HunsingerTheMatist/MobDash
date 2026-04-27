# Runs every tick when the game is running

# Check if the game has ended on time limit
scoreboard players add $GameTick md_state 1
execute if score $EndTick md_state matches 1.. if score $GameTick md_state >= $EndTick md_state run return run function mob_dash:game/end_game

# Update the bossbar timer
execute if score $EndTick md_state matches 1.. run function mob_dash:game/update_timer_bar

# Process players who joined after game start
execute as @a unless score @s md_game_idx = $GameIndex md_state run function mob_dash:game/handle_new_players

# Process targets
function mob_dash:game/target/process_targets

# Check if a new target needs to be added
function mob_dash:game/target/check_for_add_target

# Process animal handling
function mob_dash:game/animals/tick_animal_handling

# Process bounties
function mob_dash:game/bounty/tick_bounty

# Display the action bar
function mob_dash:game/display_action_bar