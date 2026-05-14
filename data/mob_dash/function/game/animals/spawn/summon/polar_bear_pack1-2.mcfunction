# Auto-generated. Spawns a polar_bear at the current position if surface and clearance pass
# Hitbox 1.4w x 1.4h. Block under: #minecraft:polar_bears_spawnable_on_alternate in #mob_dash:polar_bears_alt_biomes, BUT #minecraft:animals_spawnable_on in all others
# Pack size: 1..2 (0..1 pack-attempts after this spawn)

scoreboard players set #picked_animal_id md_state 15

execute if biome ~ ~ ~ #mob_dash:polar_bears_alt_biomes unless block ~ ~-1 ~ #minecraft:polar_bears_spawnable_on_alternate run return -21
execute unless biome ~ ~ ~ #mob_dash:polar_bears_alt_biomes unless block ~ ~-1 ~ #minecraft:animals_spawnable_on run return -21

execute unless block ~-1 ~ ~-1 #mob_dash:no_collision run return -20
execute unless block ~-1 ~ ~ #mob_dash:no_collision run return -20
execute unless block ~ ~ ~-1 #mob_dash:no_collision run return -20
execute unless block ~-1 ~1 ~-1 #mob_dash:no_collision run return -20
execute unless block ~-1 ~1 ~ #mob_dash:no_collision run return -20
execute unless block ~ ~1 ~-1 #mob_dash:no_collision run return -20
execute unless block ~ ~1 ~ #mob_dash:no_collision run return -20

# Hitbox collision check. Selector-volume span per axis is |d|+1, so
#  dx=0 → 1-block-wide search. Sized to this mob's hitbox (1-block min)
execute positioned ~-0.7 ~ ~-0.7 if entity @n[type=!#mob_dash:doesnt_block_spawns,dx=0.4,dy=0.4,dz=0.4] run return -22

scoreboard players add $polar_bear md_animal_spawns 1
execute if score #doing_pack_spawn md_state matches 0 run execute store result score #pack_attempts md_state run random value 0..1

execute store result score #baby_roll md_state run random value 0..999
execute if score #baby_roll md_state < $BabySpawnChance md_animal_config run return run summon minecraft:polar_bear ~ ~ ~ {Age:-24000, Tags: [md_custom_spawned, md_structure_persistence_checked]}
return run summon minecraft:polar_bear ~ ~ ~ {Tags: [md_custom_spawned, md_structure_persistence_checked]}
