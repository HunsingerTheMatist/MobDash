# End the game, display results, set post-game states

scoreboard players set $GameState md_state 2

scoreboard players set $Max md_score 0
scoreboard players operation $Max md_score > @e[distance=0,type=marker,tag=md_team] md_score

tag @e[distance=0,type=marker,tag=md_winner] remove md_winner
execute as @e[distance=0,type=marker,tag=md_team] if score @s md_score = $Max md_score run tag @s add md_winner

execute store result score $WinningTeams md_state if entity @e[distance=0,type=marker,tag=md_winner]

execute if score $WinningTeams md_state matches 1 run data modify storage mob_dash:data Message set value [{text:"Team ", color:gold}, {selector:"@n[distance=0,type=marker,tag=md_winner]"}, {text:" wins!", color:gold}]
execute if score $WinningTeams md_state matches 2.. run data modify storage mob_dash:data Message set value [{text:"It's a draw!", color:gold}]

title @a title "Game Over"
title @a subtitle [{storage:"mob_dash:data", nbt:Message, interpret:true}]
tellraw @a [{storage:"mob_dash:data", nbt:Message, interpret:true}]

bossbar remove mob_dash:timer

scoreboard players set $GameTick md_state 0

tellraw @a "Returning to menu in 60 seconds..."
