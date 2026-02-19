# Increase the score of team @s and the player @p who killed the target

scoreboard players operation @s md_score += @n[type=marker,tag=md_killed] md_score
scoreboard players operation @p md_player_scores += @n[type=marker,tag=md_killed] md_score

data modify storage mob_dash:data PointString set value " points"
execute if score @s md_score matches 1 run data modify storage mob_dash:data PointString set value " point"
tellraw @a [{"text": "Target "}, {"selector":"@n[type=marker,tag=md_killed]","color":"red"}, {"text": " killed by "}, {"selector":"@p"}, {"text": " from "}, {"selector":"@s"}, {"text": ", now at "}, {"score":{"objective": "md_score", "name": "@s"}, "color": "green"}, {"storage": "mob_dash:data", nbt:"PointString"}]

function mob_dash:game/update_sidebar_scores

# Check if any team has won by score
execute unless score $Win md_state matches 0 as @e[type=marker,tag=md_team] if score @s md_score >= $Win md_state run function mob_dash:game/end_game