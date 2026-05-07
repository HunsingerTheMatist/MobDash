# Cycles team_idx through 1..8 (skipping un-chosen) and adds the player to that team.
# Caller must execute this in mob_dash:md_markers positioned 0 0 0.

scoreboard players add #team_idx md_state 1
execute if score #team_idx md_state matches 9.. run scoreboard players set #team_idx md_state 1

# If the current index isn't a chosen team step to the next index
execute as @e[distance=..1,type=marker,tag=md_team,tag=!md_chosen] if score @s md_team = #team_idx md_state run return run function mob_dash:menu/teams/randomize_teams_step

scoreboard players operation @s SetTeam = #team_idx md_state
function mob_dash:menu/teams/join_team