# Reset all the marker scores & tags

scoreboard players reset @e[distance=..1,type=marker] md_score
scoreboard players reset @e[distance=..1,type=marker] md_index

tag @e[distance=..1,type=marker] remove md_selected
tag @e[distance=..1,type=marker] remove md_prev_selected
tag @e[distance=..1,type=marker] remove md_killed