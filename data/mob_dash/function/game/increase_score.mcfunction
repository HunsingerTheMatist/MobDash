# Increase the score of team @s and the player who killed it @p

scoreboard players operation @s md_score += @n[type=marker,tag=md_killed] md_score
scoreboard players operation @p md_player_scores += @n[type=marker,tag=md_killed] md_score

execute if score @s md_score matches 1 run return run tellraw @a [{"text": "Target "}, {"selector":"@n[type=marker,tag=md_killed]","color":"red"}, {"text": " killed by "}, {"selector":"@p"}, {"text": " from "}, {"selector":"@s"}, {"text": ", now at "}, {"score":{"objective": "md_score", "name": "@s"}, "color": "green"}, {"text": " point"}]
execute unless score @s md_score matches 1 run tellraw @a [{"text": "Target "}, {"selector":"@n[type=marker,tag=md_killed]","color":"red"}, {"text": " killed by "}, {"selector":"@p"}, {"text": " from "}, {"selector":"@s"}, {"text": ", now at "}, {"score":{"objective": "md_score", "name": "@s"}, "color": "green"}, {"text": " points"}]