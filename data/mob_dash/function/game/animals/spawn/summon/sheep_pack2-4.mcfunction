# Auto-generated. Spawns a sheep at the current position if surface and clearance pass
# Hitbox 0.9w x 1.3h. Block under: #minecraft:animals_spawnable_on
# Pack size: 2..4 (1..3 pack-attempts after this spawn)

scoreboard players set #picked_animal_id md_state 17

execute unless block ~ ~-1 ~ #minecraft:animals_spawnable_on run return -21

execute unless block ~ ~1 ~ #mob_dash:no_collision run return -20

# Hitbox collision check. Selector-volume span per axis is |d|+1, so
#  dx=0 → 1-block-wide search. Sized to this mob's hitbox (1-block min)
execute positioned ~ ~ ~ if entity @n[type=!#mob_dash:doesnt_block_spawns,dx=0,dy=0.3,dz=0] run return -22

scoreboard players add $sheep md_animal_spawns 1
execute if score #doing_pack_spawn md_state matches 0 run execute store result score #pack_attempts md_state run random value 1..3

execute store result score #baby_roll md_state run random value 0..999
execute if score #baby_roll md_state < $BabySpawnChance md_animal_config run return run summon minecraft:sheep ~0.5 ~ ~0.5 {Age:-24000, Tags: [md_custom_spawned, md_structure_persistence_checked]}
return run summon minecraft:sheep ~0.5 ~ ~0.5 {Tags: [md_custom_spawned, md_structure_persistence_checked]}
