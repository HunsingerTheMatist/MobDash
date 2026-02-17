# Check if the game has ended on time limit

execute if score $Tick md_state >= $EndTick md_state run function mob_dash:game/end_game