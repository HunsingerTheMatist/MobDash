# Increase the score of team @s and the player who killed the bounty

# Figure out the bounty scores each team would get
function mob_dash:game/bounty/calculate_bounty_scores

scoreboard players operation @s md_score += @s md_bounty_score
scoreboard players operation @p[tag=md_current] md_player_scores += @s md_bounty_score

data modify storage mob_dash:data Runtime.PointString set value " points"
execute if score @s md_bounty_score matches 1 run data modify storage mob_dash:data Runtime.PointString set value " point"
data modify storage mob_dash:data Runtime.PointString2 set value " points"
execute if score @s md_score matches 1 run data modify storage mob_dash:data Runtime.PointString2 set value " point"
tellraw @a [\
    {text:"Bounty "}, {selector:"@n[distance=..1,type=marker,tag=md_bounty,tag=md_killed]", color:red}, \
    {text:" worth "}, {score: {objective:md_bounty_score, name:"@s"}, color:green}, {storage:"mob_dash:data", nbt:Runtime.PointString}, \
    {text:" killed by "}, {selector:"@p[tag=md_current]"}, \
    {text:" from "}, {selector:"@s"}, \
    {text:", now at "}, {score: {objective:md_score, name:"@s"}, color:green}, {storage:"mob_dash:data", nbt:Runtime.PointString2} \
]

function mob_dash:game/sidebar/update_sidebar_scores

# Check if team @s has won by score
execute unless score $Win md_state matches 0 if score @s md_score >= $Win md_state run function mob_dash:game/end_game