# Randomly adds all players to TeamCount # of teams as evenly as possible

scoreboard players operation #team_count md_state = @s TeamCount
execute store result score #team_idx md_state run random value 1..10000

scoreboard players set #silent_joins md_state 1
execute as @a[sort=random] run function mob_dash:menu/randomize_teams_step
scoreboard players reset #silent_joins md_state

tellraw @a [{text:"Randomized players into "}, {score: {objective:md_state, name:"#team_count"}, color:gold}, {text:" teams!"}]