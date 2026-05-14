# Auto-generated. Spawns a wolf at the current position if surface and clearance pass
# Hitbox 0.6w x 0.85h. Block under: #minecraft:wolves_spawnable_on
# Pack size: 1 (no pack-spawning follow-up)

scoreboard players set #picked_animal_id md_state 19

execute unless block ~ ~-1 ~ #minecraft:wolves_spawnable_on run return -21

# Hitbox collision check. Selector-volume span per axis is |d|+1, so
#  dx=0 → 1-block-wide search. Sized to this mob's hitbox (1-block min)
execute positioned ~ ~ ~ if entity @n[type=!#mob_dash:doesnt_block_spawns,dx=0,dy=0,dz=0] run return -22

scoreboard players add $wolf md_animal_spawns 1

execute store result score #baby_roll md_state run random value 0..999
execute if score #baby_roll md_state < $BabySpawnChance md_animal_config run return run summon minecraft:wolf ~0.5 ~ ~0.5 {Age:-24000, Tags: [md_custom_spawned, md_structure_persistence_checked]}
return run summon minecraft:wolf ~0.5 ~ ~0.5 {Tags: [md_custom_spawned, md_structure_persistence_checked]}
