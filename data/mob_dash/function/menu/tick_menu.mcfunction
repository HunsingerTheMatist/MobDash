# Runs every tick in menu mode

# Keep the game stalled until starting
gamerule advance_time false
gamerule advance_weather false
gamerule spawn_mobs false
difficulty peaceful

time set noon

# World border
execute if score $BorderCooldown md_state matches 0 run execute at @e[type=marker,tag=md_spawn] run worldborder center ~ ~
execute if score $BorderCooldown md_state matches 0 run execute at @e[type=marker,tag=md_spawn] run spawnpoint @a ~ ~ ~
execute if score $BorderCooldown md_state matches 0 run execute at @e[type=marker,tag=md_spawn] run setworldspawn ~ ~ ~
execute if score $BorderCooldown md_state matches 0 run worldborder set 100
execute if score $BorderCooldown md_state matches 0.. run scoreboard players remove $BorderCooldown md_state 1

# Player griefing fixup
gamemode adventure @a[name=!"slicedlime"]
effect give @a weakness infinite 100 true
effect give @a mining_fatigue infinite 100 true
effect give @a saturation infinite 1 true

# Set allowed triggers
execute if score $OpOnly md_state matches 0 run tag @a add md_op
scoreboard players enable @a[tag=md_op] HardReset
execute as @a run trigger Reroll add 0
execute if score $OpOnly md_state matches 0 run tag @a remove md_op

# Op-only mode
execute as @a[scores={OpControl=1..}] run function mob_dash:menu/op_auth

# Menu handling
execute as @a[tag=!md_assigned] run function mob_dash:menu/new_player

scoreboard players add @a md_menu_ticks 1

# Enables/disables triggers
execute if score $OpOnly md_state matches 0 run tag @a add md_op
scoreboard players enable @a[tag=md_op] WinScore
scoreboard players enable @a[tag=md_op] TimeLimit
scoreboard players enable @a[tag=md_op] SetTeam
execute as @a run trigger HardReset add 0
execute as @a run trigger Reroll add 0
execute if score $OpOnly md_state matches 0 run tag @a remove md_op

execute as @a[scores={md_menu_ticks=600..},tag=!md_tutorial] run function mob_dash:menu/push_menu
execute as @a[tag=md_tutorial] run function mob_dash:menu/tick_tutorial

execute as @a[scores={WinScore=-2147483647..2147483647}] run function mob_dash:menu/settings/set_win_score
scoreboard players set @a WinScore -2147483648

execute as @a[scores={TimeLimit=-2147483647..2147483647}] run function mob_dash:menu/settings/set_time_limit
scoreboard players set @a TimeLimit -2147483648

# React to menu action clicks
execute as @a[scores={md_action=1}] run function mob_dash:menu/trigger_tutorial
execute as @a[scores={md_action=2}] run function mob_dash:menu/cancel_tutorial
execute as @a[scores={md_action=3}] run function mob_dash:menu/display_teams_menu
execute as @a[scores={md_action=4}] if entity @p[scores={md_team=1..8}] run function mob_dash:game/start_game
execute as @a[scores={md_action=4}] unless entity @p[scores={md_team=1..8}] run tellraw @s [{"text": "No players on any team, cannot start", "color": "red"}]
execute as @a[scores={md_action=10}] run function mob_dash:menu/settings/cycle_progression
execute as @a[scores={md_action=11}] run function mob_dash:menu/settings/cycle_increment_period
execute as @a[scores={md_action=12}] run function mob_dash:menu/settings/cycle_passive_start
execute as @a[scores={md_action=13}] run function mob_dash:menu/settings/cycle_hostiles
execute as @a[scores={md_action=14}] run function mob_dash:menu/settings/cycle_nether
execute as @a[scores={SetTeam=1..9}] run function mob_dash:menu/join_team

scoreboard players set @a md_action 0
