# Reroll the latest mob in the selected list
execute if score $OpOnly md_state matches 0 run tag @s add md_op
execute unless entity @s[tag=md_op] run tellraw @s [{"text":"Error: Only ops can run this command!","color": "red","bold": true}]

execute if entity @s[tag=md_op] if score $TargetCount md_state matches 1 run tag @e[type=marker,tag=md_selected1] add md_killed
execute if entity @s[tag=md_op] if score $TargetCount md_state matches 2 run tag @e[type=marker,tag=md_selected2] add md_killed
execute if entity @s[tag=md_op] if score $TargetCount md_state matches 3 run tag @e[type=marker,tag=md_selected3] add md_killed

execute if entity @s[tag=md_op] run function mob_dash:game/remove_target
execute if entity @s[tag=md_op] run scoreboard players remove $TotalMobsSelected md_state 1

execute if score $OpOnly md_state matches 0 run tag @s remove md_op
