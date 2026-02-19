# Calculate the score for the current target

scoreboard players operation @s md_score = @s md_time
scoreboard players operation @s md_score /= $ScorePeriod md_state
scoreboard players add @s md_score 1
scoreboard players operation @s md_score < $MaxTargetScore md_state