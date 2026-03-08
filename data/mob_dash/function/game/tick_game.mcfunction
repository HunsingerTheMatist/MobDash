# Runs every tick when the game is running

# Check if the game has ended on time limit
scoreboard players add $GameTick md_state 1
execute if score $EndTick md_state matches 1.. if score $GameTick md_state >= $EndTick md_state run function mob_dash:game/end_game

# Update the bossbar timer
execute if score $EndTick md_state matches 1.. run function mob_dash:game/update_timer_bar

# Process targets
scoreboard players remove $TargetTick md_state 1
execute if score $TargetTick md_state matches ..0 run function mob_dash:game/target/increment_target_scores

# Process animal handling
function mob_dash:game/animals/tick_animal_handling

# Process action bar
scoreboard players remove $ActionBarTick md_state 1
execute if score $ActionBarTick md_state matches ..0 run function mob_dash:game/display_action_bar
execute unless score $ActionBarCache md_state matches 1 run function mob_dash:game/display_action_bar