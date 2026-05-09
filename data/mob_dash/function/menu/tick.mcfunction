# Runs every tick in menu mode

# Handle setting up spawn once a player is present
execute unless entity @n[distance=0..,type=marker,tag=md_game_spawn] at @p align xyz positioned ~0.5 ~ ~0.5 positioned over motion_blocking_no_leaves run function mob_dash:menu/setup_spawn

scoreboard players remove @a md_menu_ticks 1
execute as @a[scores={md_menu_ticks=..0},tag=!md_tutorial] run function mob_dash:menu/push_menu
execute as @a[tag=md_tutorial] run function mob_dash:menu/tutorial/tick

# React to unauthorized menu actions
execute if score $OpOnly md_setting matches 1 as @a[tag=!md_op,scores={MenuAction=10..}] run function mob_dash:menu/op_block_action
execute if score $OpOnly md_setting matches 1 as @a[tag=!md_op,scores={TeamCount=-2147483647..2147483647}] run function mob_dash:menu/op_block_action
execute if score $OpOnly md_setting matches 1 as @a[tag=!md_op,scores={WinScore=-2147483647..2147483647}] run function mob_dash:menu/op_block_action
execute if score $OpOnly md_setting matches 1 as @a[tag=!md_op,scores={TimeLimit=-2147483647..2147483647}] run function mob_dash:menu/op_block_action

# Handle TeamCount triggers
execute as @n[scores={TeamCount=1..}] run function mob_dash:menu/teams/randomize/start
scoreboard players set @a TeamCount -2147483648
scoreboard players enable @a TeamCount

# Handle WinScore triggers
execute as @n[scores={WinScore=-2147483647..2147483647}] run function mob_dash:menu/settings/win_score/set
scoreboard players set @a WinScore -2147483648
scoreboard players enable @a WinScore

# Handle TimeLimit triggers
execute as @n[scores={TimeLimit=-2147483647..2147483647}] run function mob_dash:menu/settings/time_limit/set
scoreboard players set @a TimeLimit -2147483648
scoreboard players enable @a TimeLimit

# Handle SetTeam triggers
execute as @a[scores={SetTeam=1..9}] run function mob_dash:menu/teams/join_team
scoreboard players enable @a SetTeam

# React to menu actions
execute as @a[scores={MenuAction=1}] run function mob_dash:menu/tutorial/start
execute as @a[scores={MenuAction=2}] run function mob_dash:menu/tutorial/cancel
execute as @a[scores={MenuAction=3}] run function mob_dash:menu/teams/display_menu

execute as @n[scores={MenuAction=11}] run function mob_dash:menu/settings/difficulty_speed/cycle
execute as @n[scores={MenuAction=12}] run function mob_dash:menu/settings/increment_period/cycle
execute as @n[scores={MenuAction=13}] run function mob_dash:menu/settings/bounties/cycle
execute as @n[scores={MenuAction=14}] run function mob_dash:menu/settings/hostiles/cycle
execute as @n[scores={MenuAction=15}] run function mob_dash:menu/settings/nether/cycle

execute as @n[scores={MenuAction=20}] unless entity @p[scores={md_team=1..8}] run tellraw @s [{text:"No players on any team, cannot start", color:red}]
execute as @n[scores={MenuAction=20}] if entity @p[scores={md_team=1..8}] run return run function mob_dash:game/setup_game

scoreboard players reset @a MenuAction
scoreboard players enable @a MenuAction
