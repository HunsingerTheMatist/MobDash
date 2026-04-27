# Runs every tick in menu mode

# Keep the game stalled until starting
gamerule advance_time false
gamerule advance_weather false
gamerule spawn_mobs false
difficulty peaceful
time of overworld set noon

# Player griefing fixup
gamemode adventure @a
effect give @a weakness infinite 100 true
effect give @a mining_fatigue infinite 100 true
effect give @a saturation infinite 1 true

# Handle setting up spawn once a player is present
execute unless score $SpawnSetupDone md_state matches 1 at @p align xyz positioned ~0.5 ~ ~0.5 run function mob_dash:menu/setup_spawn

# Handle new players
execute as @a[tag=!md_assigned] run function mob_dash:menu/new_player

scoreboard players remove @a md_menu_ticks 1
execute as @a[scores={md_menu_ticks=..0},tag=!md_tutorial] run function mob_dash:menu/push_menu
execute as @a[tag=md_tutorial] run function mob_dash:menu/tick_tutorial

# React to unauthorized menu actions
execute if score $OpOnly md_setting matches 1 as @a[tag=!md_op,scores={MenuAction=10..}] run function mob_dash:menu/op_invalid_text
execute if score $OpOnly md_setting matches 1 as @a[tag=!md_op,scores={TeamCount=-2147483647..2147483647}] run function mob_dash:menu/op_invalid_text
execute if score $OpOnly md_setting matches 1 as @a[tag=!md_op,scores={WinScore=-2147483647..2147483647}] run function mob_dash:menu/op_invalid_text
execute if score $OpOnly md_setting matches 1 as @a[tag=!md_op,scores={TimeLimit=-2147483647..2147483647}] run function mob_dash:menu/op_invalid_text

# Handle TeamCount triggers
execute as @n[scores={TeamCount=1..}] run function mob_dash:menu/randomize_teams
scoreboard players set @a TeamCount -2147483648
scoreboard players enable @a TeamCount

# Handle WinScore triggers
execute as @n[scores={WinScore=-2147483647..2147483647}] run function mob_dash:menu/settings/set_win_score
scoreboard players set @a WinScore -2147483648
scoreboard players enable @a WinScore

# Handle TimeLimit triggers
execute as @n[scores={TimeLimit=-2147483647..2147483647}] run function mob_dash:menu/settings/set_time_limit
scoreboard players set @a TimeLimit -2147483648
scoreboard players enable @a TimeLimit

# Handle SetTeam triggers
execute as @a[scores={SetTeam=1..9}] run function mob_dash:menu/join_team
scoreboard players enable @a SetTeam

# React to menu actions
execute as @a[scores={MenuAction=1}] run function mob_dash:menu/trigger_tutorial
execute as @a[scores={MenuAction=2}] run function mob_dash:menu/cancel_tutorial
execute as @a[scores={MenuAction=3}] run function mob_dash:menu/display_teams_menu

execute as @n[scores={MenuAction=11}] run function mob_dash:menu/settings/cycle_difficulty_speed
execute as @n[scores={MenuAction=12}] run function mob_dash:menu/settings/cycle_increment_period
execute as @n[scores={MenuAction=13}] run function mob_dash:menu/settings/cycle_bounties
execute as @n[scores={MenuAction=14}] run function mob_dash:menu/settings/cycle_hostiles
execute as @n[scores={MenuAction=15}] run function mob_dash:menu/settings/cycle_nether

execute as @n[scores={MenuAction=20}] unless entity @p[scores={md_team=1..8}] run tellraw @s [{text:"No players on any team, cannot start", color:red}]
execute as @n[scores={MenuAction=20}] if entity @p[scores={md_team=1..8}] run scoreboard players set $GameState md_state 1

scoreboard players reset @a MenuAction
scoreboard players enable @a MenuAction