# Select a new target and display

# Increment the current pool level if enough mobs have been killed
scoreboard players operation $CurrentLevel md_state = $TotalMobsSelected md_state
scoreboard players operation $CurrentLevel md_state /= $ProgressionFactor md_state
scoreboard players add $CurrentLevel md_state 1

# Start at level 2 if passive-only start is off
scoreboard players operation $CurrentLevel md_state += $PassiveStart md_state

# Set all mobs in level $CurrentLevel or below as eligible unless they are already a target or were just selected last time
tag @e[type=marker,tag=md_eligible] remove md_eligible
execute as @e[type=marker,tag=md_target,tag=!md_selected,tag=!md_prev_selected] if score @s md_level <= $CurrentLevel md_state run tag @s add md_eligible

# Remove nether mobs if previous mob selected was a nether mob
execute as @e[type=marker,tag=md_eligible,tag=md_nether] if entity @e[tag=md_prev_selected,tag=md_nether] run tag @s remove md_eligible

# Remove hostile mobs if hostiles are off
execute as @e[type=marker,tag=md_eligible,tag=md_hostile] if score $Hostiles md_state matches 1 run tag @s remove md_eligible

# Remove nether mobs if nether is off
execute as @e[type=marker,tag=md_eligible,tag=md_nether] if score $Nether md_state matches 1 run tag @s remove md_eligible

# Make night mobs more frequent towards the night, stored in $NightValue
# Piece-wise function shown below: ($NightValue as 'y', $DayTick as 'x')
# y = 2500 {0 <= x <= 8000 }
# y = x - 5500 {8000 <= x <= 13000}
# y = 7500 {13000 <= x <= 19000}
# y = 26500 - x {19000 <= x <= 24000}
execute store result score $DayTick md_state run time query daytime
scoreboard players operation $NightValue md_state = $DayTick md_state
execute if score $DayTick md_state matches ..8000 run scoreboard players set $NightValue md_state 2500
execute if score $DayTick md_state matches 8000..13000 run scoreboard players remove $NightValue md_state 5500
execute if score $DayTick md_state matches 13000..19000 run scoreboard players set $NightValue md_state 7500
execute if score $DayTick md_state matches 19000.. run scoreboard players operation $NightValue md_state *= -1 md_const
execute if score $DayTick md_state matches 19000.. run scoreboard players add $NightValue md_state 26500

# Remove night mobs if random value is above $NightValue
execute store result score $Random md_state run random value 0..24000
execute as @e[type=marker,tag=md_eligible,tag=md_night] if score $Random md_state > $NightValue md_state run tag @s remove md_eligible

# Randomly select a mob from the list of eligible mobs
function mob_dash:game/select_from_eligible

# Display name of target
title @a title ""
title @a subtitle ["",{"text":"New Target: ","color":"gold"},{"selector":"@e[type=marker,tag=md_selected_new]","color":"red"}]
tellraw @a ["",{"text":"New Target: ","color":"gold"},{"selector":"@e[type=marker,tag=md_selected_new]","color":"red"}]

# Add the selection tags to the new selected mob
execute as @n[type=marker,tag=md_selected_new] run function mob_dash:game/add_target_tags

# Increment the mob counts
scoreboard players add $TargetCount md_state 1
scoreboard players add $TotalMobsSelected md_state 1