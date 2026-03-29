# On datapack load

# Scoreboards for bounties
scoreboard objectives add md_min_score dummy
scoreboard objectives add md_max_score dummy
scoreboard objectives add md_bounty_score dummy

# Set default configs
execute unless score $BountyMinCountdown md_config matches 1.. run scoreboard players set $BountyMinCountdown md_config 5
execute unless score $BountyMaxCountdown md_config matches 1.. run scoreboard players set $BountyMaxCountdown md_config 8

# Debug mode for bounty logic
scoreboard players set #debug_bounty md_config 0

# If no game is running, make sure sidebar is reset without bounty text
execute if score $GameState md_state matches 1..2 run return 1
function mob_dash:game/bounty/reset_sidebar