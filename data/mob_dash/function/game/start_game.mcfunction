# Start the game!

gamerule advance_time true
gamerule advance_weather true
gamerule spawn_mobs true

time set day
tp @a @n[type=marker,tag=md_spawn]
effect give @a instant_health 1 10 true
effect give @a saturation 1 10 true
effect give @a resistance 1 10 true
gamemode survival @a[team=!gray]
gamemode spectator @a[team=gray]
clear @a

worldborder set 50000

scoreboard players set $State md_state 1
scoreboard players set $TargetCount md_state 0
scoreboard players set $TotalMobsSelected md_state 0

scoreboard players set @e[type=marker] md_score 0
scoreboard players set @e[type=marker] md_time 0
tag @e[type=marker] remove md_selected
tag @e[type=marker] remove md_selected1
tag @e[type=marker] remove md_selected2
tag @e[type=marker] remove md_selected3
tag @e[type=marker] remove md_prev_selected

scoreboard players set $Tick md_state 0
scoreboard players operation $EndTick md_state = $Timeout md_state
scoreboard players operation $EndTick md_state *= 1200 md_const

# Set appropriate difficulty
execute if score $GameDifficulty md_state matches 1 run difficulty easy
execute if score $GameDifficulty md_state matches 2 run difficulty normal
execute if score $GameDifficulty md_state matches 3 run difficulty hard

# Reset scores
scoreboard players reset * md_team_scores
scoreboard players reset * md_player_scores

# Count team members
scoreboard players set @e[type=marker,tag=md_team] md_team_count 0
execute as @e[type=marker,tag=md_team] run function mob_dash:game/count_members

execute store result score $ActiveTeams md_state if entity @e[type=marker,tag=md_team,scores={md_team_count=1..}]

# Set setting factors
execute if score $ProgressionSpeed md_state matches 0 run scoreboard players set $ProgressionFactor md_state 20
execute if score $ProgressionSpeed md_state matches 1 run scoreboard players set $ProgressionFactor md_state 15
execute if score $ProgressionSpeed md_state matches 2 run scoreboard players set $ProgressionFactor md_state 10
execute if score $IncrementPeriod md_state matches 0 run scoreboard players set $ScorePeriod md_state 1200
execute if score $IncrementPeriod md_state matches 1 run scoreboard players set $ScorePeriod md_state 2400
execute if score $IncrementPeriod md_state matches 2 run scoreboard players set $ScorePeriod md_state 3600

# Scale by number of active ActiveTeams
scoreboard players operation $ProgressionFactor md_state *= $ActiveTeams md_state

execute if score $EndTick md_state matches 1.. run function mob_dash:game/setup_timer_bar
