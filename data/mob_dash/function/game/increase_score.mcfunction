# Increase the score of team @s and the player who killed the target

scoreboard players operation @s md_score += @n[distance=..1,type=marker,tag=md_killed] md_score
scoreboard players operation @p[tag=md_current] md_player_scores += @n[distance=..1,type=marker,tag=md_killed] md_score

data modify storage mob_dash:data Runtime.PointString set value " points"
execute if score @s md_score matches 1 run data modify storage mob_dash:data Runtime.PointString set value " point"
tellraw @a [\
    {text:"Target "}, {selector:"@n[distance=..1,type=marker,tag=md_killed]", color:red}, \
    {text:" killed by "}, {selector:"@p[tag=md_current]"}, \
    {text:" from "}, {selector:"@s"}, \
    {text:", now at "}, {score: {objective:md_score, name:"@s"}, color:green}, {storage:"mob_dash:data", nbt:Runtime.PointString} \
]

function mob_dash:game/update_sidebar_scores

# Check if team @s has won by score
execute unless score $Win md_state matches 0 if score @s md_score >= $Win md_state run function mob_dash:game/end_game