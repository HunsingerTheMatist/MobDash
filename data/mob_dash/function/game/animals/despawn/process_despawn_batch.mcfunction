# Process all non-persistent animals for despawn in the current batch

scoreboard players add #curr_despawn_batch md_state 1

execute unless score #debug_animal_handling md_state matches 0 run function mob_dash:game/animals/despawn/debug_despawn_chances
execute as @e[type=#mob_dash:despawnable_animals,tag=!md_persistent] if score @s md_batch_idx = #curr_despawn_batch md_state at @s run function mob_dash:game/animals/despawn/process_animal
function mob_dash:game/animals/despawn/despawn_all_tagged