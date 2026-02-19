# Reroll the latest mob in the selected list
execute if score $OpOnly md_state matches 0 run tag @s add md_op
execute unless entity @s[tag=md_op] run tellraw @s [{"text":"Error: Only ops can run this command!","color": "red","bold": true}]

execute if entity @s[tag=md_op] run function mob_dash:game/target/remove_target
execute if entity @s[tag=md_op] run scoreboard players remove $TotalMobsSelected md_state 1

execute if score $OpOnly md_state matches 0 run tag @s remove md_op
