# Reset back to menu state

scoreboard players set $GameState md_state 0

scoreboard players reset * md_menu_ticks
scoreboard players reset * md_score
scoreboard players reset * md_player_scores

scoreboard players reset * md_team_scores_base_
scoreboard players reset * md_team_scores_team1
scoreboard players reset * md_team_scores_team2
scoreboard players reset * md_team_scores_team3
scoreboard players reset * md_team_scores_team4
scoreboard players reset * md_team_scores_team5
scoreboard players reset * md_team_scores_team6
scoreboard players reset * md_team_scores_team7
scoreboard players reset * md_team_scores_team8

worldborder set 50000

bossbar remove mob_dash:timer