# Calculate the score of the current target

# Store the score
scoreboard players operation #temp md_state = @s md_score

# Update the score
scoreboard players add @s md_ticks 1
scoreboard players operation @s md_score = @s md_ticks
scoreboard players operation @s md_score /= $ScorePeriod md_state
scoreboard players add @s md_score 1
scoreboard players operation @s md_score < $MaxTargetScore md_config

# Set the #score_changed flag if the score changed
execute unless score #temp md_state = @s md_score run scoreboard players set #score_changed md_state 1
