# Sets up the game

execute unless dimension mob_dash:md_markers in mob_dash:md_markers positioned 0 0 0 run return run function mob_dash:game/setup_game

scoreboard players set $GameState md_state 2
function mob_dash:global/update_game_index

scoreboard players operation $EndTick md_state = $Timeout md_setting
scoreboard players operation $EndTick md_state *= 1200 md_const

# Reset scores
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

# Count team members
scoreboard players reset @e[distance=..1,type=marker,tag=md_team] md_team_count
execute as @e[distance=..1,type=marker,tag=md_team,scores={md_team=1..8}] run function mob_dash:game/count_members

# Set setting factors
execute if score $DifficultySpeed md_setting matches 0 run scoreboard players set $ProgressionFactor md_state 20
execute if score $DifficultySpeed md_setting matches 1 run scoreboard players set $ProgressionFactor md_state 15
execute if score $DifficultySpeed md_setting matches 2 run scoreboard players set $ProgressionFactor md_state 10
execute if score $IncrementPeriod md_setting matches 0 run scoreboard players set $ScorePeriod md_state 1200
execute if score $IncrementPeriod md_setting matches 1 run scoreboard players set $ScorePeriod md_state 2400
execute if score $IncrementPeriod md_setting matches 2 run scoreboard players set $ScorePeriod md_state 3600

# Scale the progression speed by number of active teams
execute store result score $ActiveTeams md_state if entity @e[distance=..1,type=marker,tag=md_team,scores={md_team_count=1..}]
scoreboard players operation $ProgressionFactor md_state *= $ActiveTeams md_state
