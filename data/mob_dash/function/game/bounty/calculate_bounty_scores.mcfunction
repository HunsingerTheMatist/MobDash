
# Clamp the score gained to prevent the team from getting more points than would put them in 1st place (unless they are the only team)

# If there's only 1 team the bounty is worth full points
execute if score $ActiveTeams md_state matches 1 run scoreboard players operation @e[distance=..1,type=marker,tag=md_team] md_bounty_score = @n[distance=..1,type=marker,tag=md_bounty,tag=md_selected] md_score
execute if score $ActiveTeams md_state matches 1 run return fail

# Store the current bounty score temporarily
execute as @e[distance=..1,type=marker,tag=md_team,scores={md_team_count=1..}] run scoreboard players operation @s md_state = @s md_bounty_score
# Set each team's bounty score as the score of the team in 1st place
scoreboard players operation @e[distance=..1,type=marker,tag=md_team,scores={md_team_count=1..}] md_bounty_score > @e[distance=..1,type=marker,tag=md_team,scores={md_team_count=1..}] md_score
# Subtract the team's current score from the 1st place score to determine the max points they can receive from the bounty
execute as @e[distance=..1,type=marker,tag=md_team,scores={md_team_count=1..}] run scoreboard players operation @s md_bounty_score -= @s md_score
# Cap the team's bounty score to the actual score of the bounty
scoreboard players operation @e[distance=..1,type=marker,tag=md_team,scores={md_team_count=1..}] md_bounty_score < @n[distance=..1,type=marker,tag=md_bounty,tag=md_selected] md_score

# Return whether any bounty score has changed
execute as @e[distance=..1,type=marker,tag=md_team,scores={md_team_count=1..}] unless score @s md_state = @s md_bounty_score run return 1
return fail