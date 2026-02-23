# Hard reset the minigame

kill @e[type=marker,tag=md_spawn]
kill @e[type=marker,tag=md_target]
kill @e[type=marker,tag=md_team]

scoreboard players reset * md_state

scoreboard players reset * md_menu_ticks
scoreboard players reset * md_action

scoreboard players reset * MenuAction
scoreboard players reset * SetTeam
scoreboard players reset * WinScore
scoreboard players reset * TimeLimit

scoreboard players reset * md_level
scoreboard players reset * md_weight
scoreboard players reset * md_index
scoreboard players reset * md_team
scoreboard players reset * md_team_count
scoreboard players reset * md_const
scoreboard players reset * md_score
scoreboard players reset * md_team_scores
scoreboard players reset * md_player_scores

# TODO: Figure out how to remove everything. This doesn't work
data remove storage mob_dash:data *

worldborder set 50000

bossbar remove mob_dash:timer

function mob_dash:load