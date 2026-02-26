# Display the action bar

# Only needs to be displayed every 40 ticks unless invalidated elsewhere
scoreboard players set $ActionBarTick md_state 40

# Build the action bar text component if necessary
scoreboard players set #temp md_state 0
scoreboard players set #temp2 md_state 2147483647
execute unless score $ActionBarCache md_state matches 1 run scoreboard players operation #temp2 md_state < @e[distance=..1,type=marker,tag=md_selected] md_index
execute unless score $ActionBarCache md_state matches 1 as @e[distance=..1,type=marker,tag=md_selected] if score @s md_index = #temp2 md_state run function mob_dash:game/build_action_bar
scoreboard players set $ActionBarCache md_state 1
tag @e[distance=..1,type=marker,tag=md_processed] remove md_processed

title @a actionbar [{storage:"mob_dash:data", nbt:Runtime.ActionBar, interpret:true}]