# Reset back to menu state

scoreboard players set $GameState md_state 0

scoreboard players reset * md_score
scoreboard players reset * md_player_scores

worldborder set 50000

bossbar remove mob_dash:timer