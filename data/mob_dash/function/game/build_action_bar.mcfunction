# Build the action bar

# Builds the prefix of "Target: "/"Targets: "
execute if score #temp md_state matches 0 if score $TargetCount md_state matches 1 run data modify storage mob_dash:data ActionBar set value [{text:"Target: ", color:gold}]
execute if score #temp md_state matches 0 unless score $TargetCount md_state matches 1 run data modify storage mob_dash:data ActionBar set value [{text:"Targets: ", color:gold}]

# Builds the comma separation between each target
execute unless score #temp md_state matches 0 run data modify storage mob_dash:data ActionBar append value {text:", ", color:gold}

# Writes this target's name, score, and point plurality
data modify storage mob_dash:data ActionBarTarget[0].text set from entity @s CustomName
execute store result storage mob_dash:data ActionBarTarget[2].text int 1 run scoreboard players get @s md_score
data modify storage mob_dash:data ActionBarTarget[2].text set string storage mob_dash:data ActionBarTarget[2].text
data modify storage mob_dash:data ActionBarTarget[3].text set from entity @s data.PointString

# Adds this target's message to the action bar
data modify storage mob_dash:data ActionBar append from storage mob_dash:data ActionBarTarget[]

# Go to the next target in the priority list, if any
tag @s add md_processed
scoreboard players set #temp md_state 1
scoreboard players set #temp2 md_state 2147483647
scoreboard players operation #temp2 md_state < @e[distance=..1,type=marker,tag=md_selected,tag=!md_processed] md_index
execute as @e[distance=..1,type=marker,tag=md_selected,tag=!md_processed] if score @s md_index = #temp2 md_state run function mob_dash:game/build_action_bar