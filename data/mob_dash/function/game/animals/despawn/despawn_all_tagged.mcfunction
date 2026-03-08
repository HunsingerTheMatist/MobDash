# Despawn all of the mobs tagged for despawn

# Temporarily turn the mob_drops gamerule off to save on item lag when killing the tagged animals
execute store result score #temp md_state run gamerule mob_drops
gamerule mob_drops false
execute as @e[type=#mob_dash:despawnable_animals,tag=!md_persistent,tag=md_despawn] at @s run function mob_dash:game/animals/despawn/despawn_current
execute if score #temp md_state matches 1 run gamerule mob_drops true