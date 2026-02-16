# increase the score of team @s and player @a[tag=md_current]

scoreboard players operation @s md_score += @e[type=area_effect_cloud,tag=md_killed] md_score
scoreboard players operation @a[tag=md_current] md_player_scores += @e[type=area_effect_cloud,tag=md_killed] md_score

execute if score @s md_score matches 1 run tellraw @a [{"text": "Target "}, {"selector":"@e[type=area_effect_cloud,tag=md_killed]","color":"red"}, {"text": " killed by "}, {"selector":"@a[tag=md_current]"}, {"text": " from "}, {"selector":"@s"}, {"text": ", now at "}, {"score":{"objective": "md_score", "name": "@s"}, "color": "green"}, {"text": " point"}]
execute unless score @s md_score matches 1 run tellraw @a [{"text": "Target "}, {"selector":"@e[type=area_effect_cloud,tag=md_killed]","color":"red"}, {"text": " killed by "}, {"selector":"@a[tag=md_current]"}, {"text": " from "}, {"selector":"@s"}, {"text": ", now at "}, {"score":{"objective": "md_score", "name": "@s"}, "color": "green"}, {"text": " points"}]