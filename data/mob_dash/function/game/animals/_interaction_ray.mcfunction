
#particle bubble ~ ~ ~ 0 0 0 0 1 force
#summon minecraft:block_display ~-0.025 ~-0.025 ~-0.025 {block_state:{Name:"red_stained_glass"},brightness:{sky:15,block:15}}
#summon minecraft:block_display ~-0.975 ~-0.975 ~-0.975 {block_state:{Name:"blue_stained_glass"},brightness:{sky:15,block:15}}
tag @e[type=!player,distance=..10,tag=md_ray_hit] remove md_ray_hit
execute positioned ~-0.025 ~-0.025 ~-0.025 run tag @e[type=!player,dx=0,dy=0,dz=0] add md_ray_hit
execute positioned ~-0.975 ~-0.975 ~-0.975 as @n[type=!player,dx=0,dy=0,dz=0,tag=md_ray_hit] run return run tag @s add md_ray_found

scoreboard players remove #ray_steps md_state 1
execute if score #ray_steps md_state matches 1.. positioned ^ ^ ^0.05 run function mob_dash:game/creatures/interaction_ray