# Tells the player they are not allowed to perform this action

#tellraw @s [{text:"You are not allowed to perform this action because the game is in Op-Only mode and you are not an operator", color:red}]
tellraw @s [{text:"Only operators can perform this action!", color:red}]

scoreboard players reset @s MenuAction
scoreboard players reset @s WinScore
scoreboard players reset @s TimeLimit