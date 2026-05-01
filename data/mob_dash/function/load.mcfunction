# On datapack load

#gamerule send_command_feedback false

scoreboard objectives add md_state dummy "Mob Dash Game State"
scoreboard objectives add md_setting dummy "Mob Dash Game Settings"
scoreboard objectives add md_config dummy "Mob Dash Configs"

# Menu states
scoreboard objectives add md_menu_ticks dummy "Mob Dash Menu Ticks"

# Menu triggers
scoreboard objectives add MenuAction trigger "Trigger Menu Actions"
scoreboard objectives add SetTeam trigger "Set Team for Player"
scoreboard objectives add TeamCount trigger "Number of Teams to Randomize"
scoreboard objectives add WinScore trigger "Mob Dash Win Score"
scoreboard objectives add TimeLimit trigger "Mob Dash Time Limit"

# Game states
scoreboard objectives add md_level dummy "Mob Dash Target Levels"
scoreboard objectives add md_weight dummy "Mob Dash Target Weights"
scoreboard objectives add md_index dummy "Mob Dash Target Index"
scoreboard objectives add md_team dummy "Mob Dash Team ID"
scoreboard objectives add md_team_count dummy "Mob Dash Team Member Count"
scoreboard objectives add md_const dummy "Mob Dash Constants"
scoreboard objectives add md_ticks dummy "Mob Dash Ticks"
scoreboard objectives add md_score dummy "Mob Dash Scores"
scoreboard objectives add md_game_idx dummy "Mob Dash Game Index"

scoreboard objectives add md_player_scores dummy "Scores"
scoreboard objectives add md_team_scores_base_ dummy "Team Scores"
scoreboard objectives add md_team_scores_team1 dummy "Team Scores"
scoreboard objectives add md_team_scores_team2 dummy "Team Scores"
scoreboard objectives add md_team_scores_team3 dummy "Team Scores"
scoreboard objectives add md_team_scores_team4 dummy "Team Scores"
scoreboard objectives add md_team_scores_team5 dummy "Team Scores"
scoreboard objectives add md_team_scores_team6 dummy "Team Scores"
scoreboard objectives add md_team_scores_team7 dummy "Team Scores"
scoreboard objectives add md_team_scores_team8 dummy "Team Scores"

# Set score displays
scoreboard objectives setdisplay list md_player_scores
scoreboard objectives setdisplay sidebar md_team_scores_base_
scoreboard objectives setdisplay sidebar.team.red md_team_scores_team1
scoreboard objectives setdisplay sidebar.team.green md_team_scores_team2
scoreboard objectives setdisplay sidebar.team.yellow md_team_scores_team3
scoreboard objectives setdisplay sidebar.team.blue md_team_scores_team4
scoreboard objectives setdisplay sidebar.team.light_purple md_team_scores_team5
scoreboard objectives setdisplay sidebar.team.gold md_team_scores_team6
scoreboard objectives setdisplay sidebar.team.aqua md_team_scores_team7
scoreboard objectives setdisplay sidebar.team.dark_gray md_team_scores_team8

scoreboard players set -1 md_const -1
scoreboard players set 2 md_const 2
scoreboard players set 3 md_const 3
scoreboard players set 5 md_const 5
scoreboard players set 10 md_const 10
scoreboard players set 20 md_const 20
scoreboard players set 100 md_const 100
scoreboard players set 1200 md_const 1200
scoreboard players set 24000 md_const 24000

scoreboard players add $GameState md_state 0

# Set default configs
execute unless score $MaxTargetScore md_config matches 1.. run scoreboard players set $MaxTargetScore md_config 5
execute unless score $MaxTargetCount md_config matches 1.. run scoreboard players set $MaxTargetCount md_config 3
execute unless score $AddTargetThreshold md_config matches 1.. run scoreboard players set $AddTargetThreshold md_config 3
execute unless score $UseNightWeight md_config matches 0..1 run scoreboard players set $UseNightWeight md_config 1

# Set default settings
execute unless score $OpOnly md_setting matches 0..1 run scoreboard players set $OpOnly md_setting 0
execute unless score $Win md_setting matches 0.. run scoreboard players set $Win md_setting 0
execute unless score $Timeout md_setting matches 0.. run scoreboard players set $Timeout md_setting 0
execute unless score $DifficultySpeed md_setting matches 0..2 run scoreboard players set $DifficultySpeed md_setting 1
execute unless score $IncrementPeriod md_setting matches 0..2 run scoreboard players set $IncrementPeriod md_setting 1
execute unless score $Bounties md_setting matches 0..1 run scoreboard players set $Bounties md_setting 1
execute unless score $Hostiles md_setting matches 0..2 run scoreboard players set $Hostiles md_setting 2
execute unless score $Nether md_setting matches 0..1 run scoreboard players set $Nether md_setting 1

# Set up animal handling
function mob_dash:game/animals/load_animal_handling

# Set up bounties
function mob_dash:game/bounty/load_bounty

# TODO: Fix this in the 1.20 branch!
function mob_dash:menu/settings/update_op_only_text
function mob_dash:menu/settings/update_win_score_text
function mob_dash:menu/settings/update_time_limit_text
function mob_dash:menu/settings/update_difficulty_speed_text
function mob_dash:menu/settings/update_increment_period_text
function mob_dash:menu/settings/update_bounties_text
function mob_dash:menu/settings/update_hostiles_text
function mob_dash:menu/settings/update_nether_text

# Store various text components in storage for future use
function mob_dash:load/store_text

# Set the current version
data modify storage mob_dash:data Version set value "beta 0.9"

# Check if the md_markers dimension exists
scoreboard players set #dimension_state md_state 1
execute in mob_dash:md_markers run scoreboard players remove #dimension_state md_state 1
execute if score #dimension_state md_state matches 1.. run return run tellraw @a [{text:"Custom dimension 'md_markers' not loaded! Try closing and re-opening the world!", color:red}]

# Set up the game marker entities
function mob_dash:load/setup_markers

# Set up the spawn if there is no game running & no current spawn set up
execute if score $GameState md_state matches 2..4 run return 1
execute if entity @n[distance=0..,type=marker,tag=md_spawn] run return 1
function mob_dash:menu/reset