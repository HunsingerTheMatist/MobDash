# Set the time limit
execute if score $OpOnly md_state matches 0 run tag @s add md_op
execute unless entity @s[tag=md_op] run tellraw @s [{"text":"Error: Only ops can run this command!","color": "red","bold": true}]

execute if entity @s[tag=md_op] run scoreboard players operation $Timeout md_state = @s TimeLimit
execute if entity @s[tag=md_op] if score $Timeout md_state matches ..-1 run scoreboard players set $Timeout md_state 0

execute if entity @s[tag=md_op] run function mob_dash:menu/display_menu

execute if score $OpOnly md_state matches 0 run tag @s remove md_op