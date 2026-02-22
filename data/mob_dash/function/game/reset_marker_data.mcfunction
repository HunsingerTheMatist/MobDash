# Reset all the marker scores & tags

scoreboard players reset @e[distance=0,type=marker] md_score
scoreboard players reset @e[distance=0,type=marker] md_time

tag @e[distance=0,type=marker] remove md_selected
tag @e[distance=0,type=marker] remove md_selected1
tag @e[distance=0,type=marker] remove md_selected2
tag @e[distance=0,type=marker] remove md_selected3
tag @e[distance=0,type=marker] remove md_prev_selected
tag @e[distance=0,type=marker] remove md_killed