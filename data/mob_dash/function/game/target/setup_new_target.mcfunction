# Display name of target
data modify storage mob_dash:data Runtime.Message set value [{text:"New Target: ", color:gold}, {selector:"@s", color:red}]
title @a title ""
title @a subtitle [{storage:"mob_dash:data", nbt:Runtime.Message, interpret:true}]
tellraw @a [{storage:"mob_dash:data", nbt:Runtime.Message, interpret:true}]

# Add the selection tags to the new selected mob
tag @s remove md_selected_new
tag @s add md_selected
tag @s add md_prev_selected

# Set this target's priority index
scoreboard players operation @s md_index = $TotalMobsSelected md_state

# Set the string of the target's points to 'point' since it starts at 1
scoreboard players set @s md_ticks 0
scoreboard players set @s md_score 1
data modify entity @s data.PointString set value " point"