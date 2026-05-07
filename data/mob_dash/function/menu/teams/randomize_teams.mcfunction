# Randomly adds all players to TeamCount # of teams as evenly as possible

execute unless dimension mob_dash:md_markers in mob_dash:md_markers positioned 0 0 0 run return run function mob_dash:menu/teams/randomize_teams

# Pick which team colors to use (prioritizing currently-occupied teams)
function mob_dash:menu/teams/randomize_team_choices

execute store result score #team_idx md_state run random value 0..7

scoreboard players set #silent_joins md_state 1
execute if entity @n[distance=..1,type=marker,tag=md_chosen] as @a[sort=random] run function mob_dash:menu/teams/randomize_teams_step
scoreboard players reset #silent_joins md_state

tellraw @a [{text:"Randomized players into "}, {score: {objective:TeamCount, name:"@s"}, color:gold}, {text:" teams!"}]