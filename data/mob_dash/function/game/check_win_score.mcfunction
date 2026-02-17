# Check if any team has enough points to win the game

execute as @e[type=marker,tag=md_team] if score @s md_score >= $Win md_state run function mob_dash:game/end_game
