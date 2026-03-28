# Select a new target and display

# Increment the current pool level if enough mobs have been killed
scoreboard players operation $CurrentLevel md_state = $TotalMobsSelected md_state
scoreboard players operation $CurrentLevel md_state /= $ProgressionFactor md_state
scoreboard players add $CurrentLevel md_state 1

# Start at level 2 if passive-only start is off OR if hostiles are off
execute if score $PassiveStart md_state matches 0 run scoreboard players add $CurrentLevel md_state 1
execute unless score $PassiveStart md_state matches 0 if score $Hostiles md_state matches 0 run scoreboard players add $CurrentLevel md_state 1

# Set all mobs in level $CurrentLevel or below as eligible unless they are already a target or were just selected last time
tag @e[distance=..1,type=marker,tag=md_eligible] remove md_eligible
execute as @e[distance=..1,type=marker,tag=md_target,tag=!md_selected,tag=!md_prev_selected] if score @s md_level <= $CurrentLevel md_state run tag @s add md_eligible

# Remove nether mobs if previous mob selected was a nether mob
execute if entity @n[distance=..1,type=marker,tag=md_target,tag=md_prev_selected,tag=md_nether] run tag @e[distance=..1,type=marker,tag=md_eligible,tag=md_nether] remove md_eligible

# Remove hostile mobs if hostiles are off
execute if score $Hostiles md_state matches 0 run tag @e[distance=..1,type=marker,tag=md_eligible,tag=md_hostile] remove md_eligible

# Remove nether mobs if nether is off
execute if score $Nether md_state matches 0 run tag @e[distance=..1,type=marker,tag=md_eligible,tag=md_nether] remove md_eligible

execute if score $UseNightWeight md_state matches 1 run function mob_dash:game/target/check_night_eligibility

# Randomly select a mob from the list of eligible mobs
function mob_dash:game/target/choose_from_eligible

tag @e[distance=..1,type=marker,tag=md_target,tag=md_prev_selected] remove md_prev_selected
execute as @n[distance=..1,type=marker,tag=md_target,tag=md_selected_new] run function mob_dash:game/target/setup_new_target

# Increment the mob counts
scoreboard players add $TargetCount md_state 1
scoreboard players add $TotalMobsSelected md_state 1

# Set the next score increment time
scoreboard players operation $TargetTick md_state = $ScorePeriod md_state

# Delay next bounty selection by up to 100 ticks if necessary to prevent title overlap
execute if score $BountyTick md_state matches ..1 if score #bounty_countdown_minute md_state matches ..99 run scoreboard players set #bounty_countdown_minute md_state 100

# Invalidate action bar cache
scoreboard players set $ActionBarCache md_state 0