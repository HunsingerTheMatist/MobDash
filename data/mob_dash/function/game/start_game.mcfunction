# Start the game!

gamerule advance_time true
gamerule advance_weather true
gamerule spawn_mobs true

time set day
tp @a @n[type=marker,tag=md_spawn]
clear @a
xp add @a -1000 levels
effect clear @a
effect give @a instant_health 1 10 true
effect give @a saturation 1 10 true
effect give @a resistance 1 10 true
gamemode survival @a[team=!gray]
gamemode spectator @a[team=gray]

worldborder set 50000

scoreboard players set $GameState md_state 1
scoreboard players set $TargetCount md_state 0
scoreboard players set $TotalMobsSelected md_state 0

execute in mob_dash:mb_markers positioned 0 0 0 run function mob_dash:game/reset_marker_data

scoreboard players set $GameTick md_state 0
scoreboard players operation $EndTick md_state = $Timeout md_state
scoreboard players operation $EndTick md_state *= 1200 md_const

# Set appropriate difficulty
execute if score $GameDifficulty md_state matches 1 run difficulty easy
execute if score $GameDifficulty md_state matches 2 run difficulty normal
execute if score $GameDifficulty md_state matches 3 run difficulty hard

# Reset scores
scoreboard players reset * md_team_scores
scoreboard players reset * md_player_scores

# Remove triggers
scoreboard players add @a WinScore 0
scoreboard players add @a TimeLimit 0
scoreboard players add @a SetTeam 0
scoreboard players reset @a WinScore
scoreboard players reset @a TimeLimit
scoreboard players reset @a SetTeam

# Count team members
execute in mob_dash:mb_markers positioned 0 0 0 run scoreboard players reset @e[distance=..1,type=marker,tag=md_team] md_team_count
execute in mob_dash:mb_markers positioned 0 0 0 as @e[distance=..1,type=marker,tag=md_team,scores={md_team=1..8}] run function mob_dash:game/count_members

# Set setting factors
execute if score $DifficultySpeed md_state matches 0 run scoreboard players set $ProgressionFactor md_state 20
execute if score $DifficultySpeed md_state matches 1 run scoreboard players set $ProgressionFactor md_state 15
execute if score $DifficultySpeed md_state matches 2 run scoreboard players set $ProgressionFactor md_state 10
execute if score $IncrementPeriod md_state matches 0 run scoreboard players set $ScorePeriod md_state 1200
execute if score $IncrementPeriod md_state matches 1 run scoreboard players set $ScorePeriod md_state 2400
execute if score $IncrementPeriod md_state matches 2 run scoreboard players set $ScorePeriod md_state 3600

# Scale the progression speed by number of active teams
execute in mob_dash:mb_markers positioned 0 0 0 store result score $ActiveTeams md_state if entity @e[distance=..1,type=marker,tag=md_team,scores={md_team_count=1..}]
scoreboard players operation $ProgressionFactor md_state *= $ActiveTeams md_state

execute if score $EndTick md_state matches 1.. run function mob_dash:game/setup_timer_bar
