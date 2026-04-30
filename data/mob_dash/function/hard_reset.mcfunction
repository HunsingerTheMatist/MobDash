# Hard reset the minigame

function mob_dash:menu/reset

kill @e[type=marker,tag=md_spawn]
kill @e[type=marker,tag=md_team]
kill @e[type=marker,tag=md_target]
kill @e[type=marker,tag=md_bounty]

tag @a remove md_current
tag @a remove md_op
tag @a remove md_tutorial

scoreboard players reset * md_state

scoreboard players reset * MenuAction
scoreboard players reset * TeamCount
scoreboard players reset * SetTeam
scoreboard players reset * WinScore
scoreboard players reset * TimeLimit

scoreboard players reset * md_level
scoreboard players reset * md_weight
scoreboard players reset * md_index
scoreboard players reset * md_team
scoreboard players reset * md_team_count
scoreboard players reset * md_const
scoreboard players reset * md_game_idx

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

data remove storage mob_dash:data Templates
data remove storage mob_dash:data Runtime
data remove storage mob_dash:data Settings

function mob_dash:load