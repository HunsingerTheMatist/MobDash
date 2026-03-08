
scoreboard players set #ray_steps md_state 120
execute anchored eyes positioned ^ ^ ^0.05 run function mob_dash:game/creatures/_interaction_ray
execute as @n[tag=md_ray_found] run say looking at
execute unless entity @n[tag=md_ray_found] run say FAILED
tag @e[tag=md_ray_hit] remove md_ray_hit
tag @n[tag=md_ray_found] remove md_ray_found