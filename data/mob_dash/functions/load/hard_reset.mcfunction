# Hard reset the minigame
execute if score $OpOnly md_state matches 0 run tag @s add md_op
execute unless entity @s[tag=md_op] run tellraw @s [{"text":"Error: Only ops can run this command!","color": "red","bold": true}]

execute if entity @s[tag=md_op] run kill @e[type=minecraft:area_effect_cloud]
execute if entity @s[tag=md_op] run scoreboard objectives remove md_state
execute if entity @s[tag=md_op] run scoreboard objectives remove md_menu_ticks

execute if entity @s[tag=md_op] run function mob_dash:load

execute if score $OpOnly md_state matches 0 run tag @s remove md_op