# Auto-generated. Spawns a turtle at the current position if surface and clearance pass
# Hitbox 1.2w x 0.4h. Block under: minecraft:sand
# Pack size: 2..5 (1..4 pack-attempts after this spawn)

scoreboard players set #picked_animal_id md_state 18

execute unless block ~ ~-1 ~ minecraft:sand run return -21

execute unless block ~-1 ~ ~-1 #mob_dash:no_collision run return -20
execute unless block ~-1 ~ ~ #mob_dash:no_collision run return -20
execute unless block ~ ~ ~-1 #mob_dash:no_collision run return -20

# Hitbox collision check. Selector-volume span per axis is |d|+1, so
#  dx=0 → 1-block-wide search. Sized to this mob's hitbox (1-block min)
execute positioned ~-0.6 ~ ~-0.6 if entity @n[type=!#mob_dash:doesnt_block_spawns,dx=0.2,dy=0,dz=0.2] run return -22

scoreboard players add $turtle md_animal_spawns 1
execute if score #doing_pack_spawn md_state matches 0 run execute store result score #pack_attempts md_state run random value 1..4

return run summon minecraft:turtle ~ ~ ~ {Tags: [md_custom_spawned, md_structure_persistence_checked]}
