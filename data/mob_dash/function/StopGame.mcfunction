# Stops the game manually

execute unless score $GameState md_state matches 1 run return run tellraw @s [{text:"No game currently running!", color:red}]
function mob_dash:game/end_game