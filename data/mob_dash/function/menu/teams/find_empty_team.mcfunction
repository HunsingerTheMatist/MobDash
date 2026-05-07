# Runs for every player on first joining the game

scoreboard players add @s SetTeam 1
execute if score @s SetTeam matches 8.. run scoreboard players set @s SetTeam 1
execute if score #temp md_state matches ..8 as @a if score @s md_team = @p[tag=md_current] SetTeam run return run function mob_dash:menu/teams/find_empty_team

function mob_dash:menu/teams/join_team