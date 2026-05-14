# Auto-generated. Spawns a camel at the current position if surface and clearance pass
# Hitbox 1.7w x 2.375h. Block under: #minecraft:camels_spawnable_on
# Pack size: 1 (no pack-spawning follow-up)

scoreboard players set #picked_animal_id md_state 2

execute unless block ~ ~-1 ~ #minecraft:camels_spawnable_on run return -21

execute unless block ~-1 ~ ~-1 #mob_dash:no_collision run return -20
execute unless block ~-1 ~ ~ #mob_dash:no_collision run return -20
execute unless block ~ ~ ~-1 #mob_dash:no_collision run return -20
execute unless block ~-1 ~1 ~-1 #mob_dash:no_collision run return -20
execute unless block ~-1 ~1 ~ #mob_dash:no_collision run return -20
execute unless block ~ ~1 ~-1 #mob_dash:no_collision run return -20
execute unless block ~ ~1 ~ #mob_dash:no_collision run return -20
execute unless block ~-1 ~2 ~-1 #mob_dash:no_collision run return -20
execute unless block ~-1 ~2 ~ #mob_dash:no_collision run return -20
execute unless block ~ ~2 ~-1 #mob_dash:no_collision run return -20
execute unless block ~ ~2 ~ #mob_dash:no_collision run return -20

# Hitbox collision check. Selector-volume span per axis is |d|+1, so
#  dx=0 → 1-block-wide search. Sized to this mob's hitbox (1-block min)
execute positioned ~-0.85 ~ ~-0.85 if entity @n[type=!#mob_dash:doesnt_block_spawns,dx=0.7,dy=1.375,dz=0.7] run return -22

scoreboard players add $camel md_animal_spawns 1

return run summon minecraft:camel ~ ~ ~ {Tags: [md_custom_spawned, md_structure_persistence_checked]}
