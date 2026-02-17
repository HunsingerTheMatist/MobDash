# On datapack load

scoreboard objectives add md_state dummy "Mob Dash Game State"

# Menu states
scoreboard objectives add md_menu_ticks dummy "Mob Dash Menu Ticks"
scoreboard objectives add md_action dummy "Mob Dash Menu Actions"
scoreboard objectives add OpControl dummy "Op-only control"

# Menu triggers
scoreboard objectives add SetTeam trigger "Set Team for player"
scoreboard objectives add WinScore trigger "Mob Dash Win Score"
scoreboard objectives add TimeLimit trigger "Mob Dash Time Limit"

# Game states
scoreboard objectives add md_level dummy "Mob Dash Target Levels"
scoreboard objectives add md_weight dummy "Mob Dash Target Weights"
scoreboard objectives add md_team dummy "Mob Dash Team ID"
scoreboard objectives add md_team_count dummy "Mob Dash Team Member Count"
scoreboard objectives add md_const dummy "Mob Dash Constants"
scoreboard objectives add md_time dummy "Mob Dash Target Times"
scoreboard objectives add md_score dummy "Mob Dash Team Scores"
scoreboard objectives add md_team_scores dummy "Team Scores"
scoreboard objectives add md_player_scores dummy "Scores"

# Game triggers
scoreboard objectives add HardReset trigger "Hard Reset for Mob Dash"
scoreboard objectives add Reroll trigger "Reroll latest Mob Dash target"

# Set score displays
scoreboard objectives setdisplay list md_player_scores
scoreboard objectives setdisplay sidebar md_team_scores

function mob_dash:load/create_target_scoreboards

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

# Set default settings
scoreboard players set $ProgressionSpeed md_state 1
scoreboard players set $IncrementPeriod md_state 1
scoreboard players set $PassiveStart md_state 1
scoreboard players set $Hostiles md_state 0
scoreboard players set $Nether md_state 0

scoreboard players add $OpOnly md_state 0

execute store result score $Temp md_state run difficulty
execute if score $Temp md_state matches 1.. run scoreboard players operation $GameDifficulty md_state = $Temp md_state

# TODO: Fix this in the 1.20 branch!
# function mob_dash:menu/settings/update_progression_text
# function mob_dash:menu/settings/update_increment_period_text
# function mob_dash:menu/settings/update_passive_start_text
# function mob_dash:menu/settings/update_hostiles_text
# function mob_dash:menu/settings/update_nether_text

forceload add 0 0
execute unless entity @n[type=minecraft:marker,tag=md_target] run function mob_dash:load/create_targets
execute unless entity @n[type=minecraft:marker,tag=md_team] run function mob_dash:load/create_teams

function mob_dash:game/reset