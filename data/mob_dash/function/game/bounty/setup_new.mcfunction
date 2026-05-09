
# Add the selection tags to the new selected mob
tag @s remove md_selected_new
tag @s add md_selected
tag @s add md_prev_selected

# Randomize score from the bounty's min_score to the max_score
scoreboard players operation #temp md_state = @s md_max_score
scoreboard players operation #temp md_state -= @s md_min_score
execute store result score @s md_score run random value 0..1000
scoreboard players operation @s md_score %= #temp md_state
execute if score #temp md_state matches 0 run scoreboard players set @s md_score 0
scoreboard players operation @s md_score += @s md_min_score

# Display name of bounty
data modify storage mob_dash:data Runtime.Message set value [{text:"New Bounty: ", color:gold}, {selector:"@s", color:red}]
title @a title ""
title @a subtitle [{storage:"mob_dash:data", nbt:Runtime.Message, interpret:true}]
tellraw @a [{storage:"mob_dash:data", nbt:Runtime.Message, interpret:true}, {text: " worth max ", color:gold}, {score: {objective:md_score, name:"@s"}, color:red}, {text: " points"}]

# Writes this bounty's name & score for display in the sidebar
#data modify storage mob_dash:data Templates.Bounty.Name.text set from entity @s CustomName
#execute store result storage mob_dash:data Templates.Bounty.Score.text int 1 run scoreboard players get @s md_score
#data modify storage mob_dash:data Templates.Bounty.Score.text set string storage mob_dash:data Templates.Bounty.Score.text
