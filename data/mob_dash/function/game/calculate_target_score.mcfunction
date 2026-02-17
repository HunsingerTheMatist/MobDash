# Calculate the score for the current target

scoreboard players operation @s md_score = @s md_time
scoreboard players operation @s md_score /= $ScorePeriod md_state
scoreboard players add @s md_score 1
execute if score @s md_score matches 6.. run scoreboard players set @s md_score 5