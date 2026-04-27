# Iterates the team_idx counter and adds the player to that team

scoreboard players operation #team_idx md_state %= #team_count md_state
scoreboard players add #team_idx md_state 1
scoreboard players operation @s SetTeam = #team_idx md_state

function mob_dash:menu/join_team