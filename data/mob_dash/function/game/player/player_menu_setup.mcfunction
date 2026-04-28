# Runs for every player when joining the menu

function mob_dash:game/player/reset_player

# Player griefing fixup
#effect give @s weakness infinite 100 true
#effect give @s mining_fatigue infinite 100 true
effect give @s saturation infinite 1 true
gamemode adventure @s

function mob_dash:menu/welcome

execute if score @s md_team matches 1..9 run return 1

tag @s add md_current
scoreboard players set #temp md_state 0
execute store result score @s SetTeam run random value 1..8
execute run function mob_dash:menu/find_empty_team
tag @s remove md_current