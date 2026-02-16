# Randomize a number from [1-$EligibleCount]
function mob_dash:randomize
scoreboard players operation $MobChoice md_state = $Random md_state
scoreboard players operation $MobChoice md_state %= $EligibleCount md_state
scoreboard players add $MobChoice md_state 1

# Select the mob if it exists
execute as @e[type=area_effect_cloud,tag=md_eligible] run function mob_dash:game/get_mob_from_choice

# De-select the mob if a random number from [0-4] is greater than the mob's weight
function mob_dash:randomize
scoreboard players operation $WeightRandom md_state = $Random md_state
scoreboard players operation $WeightRandom md_state %= 5 md_const
execute as @e[type=area_effect_cloud,tag=md_selected_new] if score $WeightRandom md_state >= @s md_weight run tag @s remove md_selected_new

#tellraw @a [{"text": "$MobChoice: "},{"score":{"objective": "md_state", "name": "$MobChoice"}}]
#tellraw @a [{"text": "Md Target: "},{"score":{"objective": "md_target", "name": "@e[type=area_effect_cloud,tag=md_selected_new,limit=1]"}}]

execute unless entity @e[type=area_effect_cloud,tag=md_selected_new] run function mob_dash:game/random_select