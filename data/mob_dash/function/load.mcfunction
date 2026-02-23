# On datapack load

scoreboard objectives add md_state dummy "Mob Dash Game State"

# Menu states
scoreboard objectives add md_menu_ticks dummy "Mob Dash Menu Ticks"
scoreboard objectives add md_action dummy "Mob Dash Menu Actions"

# Menu triggers
scoreboard objectives add MenuAction trigger "Trigger Menu Actions"
scoreboard objectives add SetTeam trigger "Set Team for player"
scoreboard objectives add WinScore trigger "Mob Dash Win Score"
scoreboard objectives add TimeLimit trigger "Mob Dash Time Limit"

# Game states
scoreboard objectives add md_level dummy "Mob Dash Target Levels"
scoreboard objectives add md_weight dummy "Mob Dash Target Weights"
scoreboard objectives add md_index dummy "Mob Dash Target Index"
scoreboard objectives add md_team dummy "Mob Dash Team ID"
scoreboard objectives add md_team_count dummy "Mob Dash Team Member Count"
scoreboard objectives add md_const dummy "Mob Dash Constants"
scoreboard objectives add md_score dummy "Mob Dash Team Scores"
scoreboard objectives add md_team_scores dummy "Team Scores"
scoreboard objectives add md_player_scores dummy "Scores"

# Set score displays
scoreboard objectives setdisplay list md_player_scores
scoreboard objectives setdisplay sidebar md_team_scores

scoreboard players set -1 md_const -1
scoreboard players set 2 md_const 2
scoreboard players set 5 md_const 5
scoreboard players set 20 md_const 20
scoreboard players set 100 md_const 100
scoreboard players set 1200 md_const 1200
scoreboard players set 24000 md_const 24000

scoreboard players add $TargetCount md_state 0
scoreboard players add $Win md_state 0
scoreboard players add $Timeout md_state 0

# Set default configs
execute unless score $MaxTargetScore md_state matches 1.. run scoreboard players set $MaxTargetScore md_state 5
execute unless score $MaxTargetCount md_state matches 1.. run scoreboard players set $MaxTargetCount md_state 3
execute unless score $AddTargetThreshold md_state matches 1.. run scoreboard players set $AddTargetThreshold md_state 3
execute unless score $UseNightWeight md_state matches 0..1 run scoreboard players set $UseNightWeight md_state 1

# Set default settings
execute unless score $OpOnly md_state matches 0..1 run scoreboard players set $OpOnly md_state 0
execute unless score $DifficultySpeed md_state matches 0..2 run scoreboard players set $DifficultySpeed md_state 1
execute unless score $IncrementPeriod md_state matches 0..2 run scoreboard players set $IncrementPeriod md_state 1
execute unless score $PassiveStart md_state matches 0..1 run scoreboard players set $PassiveStart md_state 1
execute unless score $Hostiles md_state matches 0..1 run scoreboard players set $Hostiles md_state 1
execute unless score $Nether md_state matches 0..1 run scoreboard players set $Nether md_state 1

execute store result score #temp md_state run difficulty
execute if score #temp md_state matches 1.. run scoreboard players operation $GameDifficulty md_state = #temp md_state

# TODO: Fix this in the 1.20 branch!
function mob_dash:menu/settings/update_difficulty_speed_text
function mob_dash:menu/settings/update_increment_period_text
function mob_dash:menu/settings/update_passive_start_text
function mob_dash:menu/settings/update_hostiles_text
function mob_dash:menu/settings/update_nether_text

# Store various text components in storage for future use
function mob_dash:load/store_text

# Sets up the game marker entities in the mb_markers dimension
# Schedule is necessary to ensure the chunk is loaded when the 'setup_markers' function runs
execute in mob_dash:mb_markers run forceload add 0 0
schedule function mob_dash:load/setup_markers 1

function mob_dash:game/reset