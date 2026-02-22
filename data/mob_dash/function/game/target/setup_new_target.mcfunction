# Display name of target
data modify storage mob_dash:data Message set value [{text:"New Target: ", color:gold}, {selector:"@s", color:red}]
title @a title ""
title @a subtitle [{storage:"mob_dash:data", nbt:Message, interpret:true}]
tellraw @a [{storage:"mob_dash:data", nbt:Message, interpret:true}]

# Add the selection tags to the new selected mob
tag @s remove md_selected_new
tag @s add md_selected
tag @s add md_prev_selected

# Set the string of the target's points to 'point' since it starts at 1
execute unless entity @n[distance=0,type=marker,tag=md_selected1] run data modify storage mob_dash:data PointStringMob1 set value " point"
execute unless entity @n[distance=0,type=marker,tag=md_selected2] run data modify storage mob_dash:data PointStringMob2 set value " point"
execute unless entity @n[distance=0,type=marker,tag=md_selected3] run data modify storage mob_dash:data PointStringMob3 set value " point"

# Give the correct tag depending on how many other mobs are currently targets
execute unless entity @n[distance=0,type=marker,tag=md_selected1] run return run tag @s add md_selected1
execute unless entity @n[distance=0,type=marker,tag=md_selected2] run return run tag @s add md_selected2
tag @s add md_selected3