# Remove the current animal from its despawn batch

scoreboard players reset @s md_batch_idx
tag @s remove md_despawn_batched

function mob_dash:game/animals/debug_glowing