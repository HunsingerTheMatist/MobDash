# Process all non-persistent animals in the current despawn batch (0..9)
# The has_or_is_passenger predicate filters at the selector so animals carrying
#  or riding another entity are skipped before any per-animal work happens

# mob_drops is toggled off across the iteration so animals killed via the
#  cascade below don't drop items. One toggle pair per batch covers however
#  many despawns roll
execute store result score #temp md_state run gamerule mob_drops
gamerule mob_drops false
execute as @e[type=#mob_dash:despawnable_animals,tag=!md_persistent] \
    if score @s md_batch_id = #curr_despawn_batch md_state \
    unless predicate mob_dash:has_or_is_passenger at @s \
    unless function mob_dash:game/animals/despawn/not_eligible \
    if function mob_dash:game/animals/despawn/roll run \
    function mob_dash:game/animals/despawn/kill
execute if score #temp md_state matches 1 run gamerule mob_drops true

# Advance to the next batch slot for the next dispatch tick
scoreboard players add #curr_despawn_batch md_state 1
