tag @e[type=marker] remove md_prev_selected

tag @s remove md_selected_new
tag @s add md_selected
tag @s add md_prev_selected

# Give the correct tag depending on how many other mobs are currently targets
execute unless entity @n[tag=md_selected1] run return run tag @s add md_selected1
execute unless entity @n[tag=md_selected2] run return run tag @s add md_selected2
tag @s add md_selected3