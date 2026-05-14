# Auto-generated. Spawns a rabbit at the current position if surface and clearance pass
# Hitbox 0.4w x 0.5h. Block under: #minecraft:rabbits_spawnable_on
# Pack size: 2..3 (1..2 pack-attempts after this spawn)

scoreboard players set #picked_animal_id md_state 16

execute unless block ~ ~-1 ~ #minecraft:rabbits_spawnable_on run return -21

# Hitbox collision check. Selector-volume span per axis is |d|+1, so
#  dx=0 → 1-block-wide search. Sized to this mob's hitbox (1-block min)
execute positioned ~ ~ ~ if entity @n[type=!#mob_dash:doesnt_block_spawns,dx=0,dy=0,dz=0] run return -22

scoreboard players add $rabbit md_animal_spawns 1
execute if score #doing_pack_spawn md_state matches 0 run execute store result score #pack_attempts md_state run random value 1..2

execute store result score #baby_roll md_state run random value 0..999
execute if score #baby_roll md_state < $BabySpawnChance md_animal_config run return run summon minecraft:rabbit ~0.5 ~ ~0.5 {Age:-24000, Tags: [md_custom_spawned, md_structure_persistence_checked]}
return run summon minecraft:rabbit ~0.5 ~ ~0.5 {Tags: [md_custom_spawned, md_structure_persistence_checked]}
