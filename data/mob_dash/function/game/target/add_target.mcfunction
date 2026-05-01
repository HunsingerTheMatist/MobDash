# Select a new target and display

# Increment the current pool level if enough mobs have been killed
scoreboard players operation $CurrentLevel md_state = $TotalMobsSelected md_state
scoreboard players operation $CurrentLevel md_state /= $ProgressionFactor md_state
scoreboard players add $CurrentLevel md_state 1

# Start at level 2 unless hostiles are only off at the start
# Hostiles Off (0): lvl 2
# Hostiles On (1): lvl 2
# Hostiles Off at Start (2): lvl 1
execute unless score $Hostiles md_setting matches 2 run scoreboard players add $CurrentLevel md_state 1

# Set all mobs in level $CurrentLevel or below as eligible unless they are already a target or were just selected last time
tag @e[distance=..1,type=marker,tag=md_eligible] remove md_eligible
execute as @e[distance=..1,type=marker,tag=md_target,tag=!md_selected,tag=!md_prev_selected] if score @s md_level <= $CurrentLevel md_state run tag @s add md_eligible

# Remove nether mobs if any of the current targets are nether mobs
execute if entity @n[distance=..1,type=marker,tag=md_target,tag=md_selected,tag=md_nether] run tag @e[distance=..1,type=marker,tag=md_eligible,tag=md_nether] remove md_eligible

# Remove hostile mobs if hostiles are off or if the difficulty is peaceful
execute if score $Hostiles md_setting matches 0 run tag @e[distance=..1,type=marker,tag=md_eligible,tag=md_hostile] remove md_eligible
execute store result score #temp md_state run difficulty
execute unless score $Hostiles md_setting matches 0 if score #temp md_state matches 0 run tag @e[distance=..1,type=marker,tag=md_eligible,tag=md_hostile] remove md_eligible

# Remove nether mobs if nether is off
execute if score $Nether md_setting matches 0 run tag @e[distance=..1,type=marker,tag=md_eligible,tag=md_nether] remove md_eligible

execute if score $UseNightWeight md_config matches 1 run function mob_dash:game/target/check_night_eligibility

# Randomly select a mob from the list of eligible mobs
function mob_dash:game/target/choose_from_eligible

tag @e[distance=..1,type=marker,tag=md_target,tag=md_prev_selected] remove md_prev_selected
execute as @n[distance=..1,type=marker,tag=md_target,tag=md_selected_new] run function mob_dash:game/target/setup_new_target

# Increment the mob counts
scoreboard players add $TargetCount md_state 1
scoreboard players add $TotalMobsSelected md_state 1

# Delay next bounty selection by up to 100 ticks if necessary to prevent title overlap
execute if score $BountyTick md_state matches ..1 if score #bounty_countdown_minute md_state matches ..99 run scoreboard players set #bounty_countdown_minute md_state 100

# Invalidate action bar cache
scoreboard players set $ActionBarCache md_state 0