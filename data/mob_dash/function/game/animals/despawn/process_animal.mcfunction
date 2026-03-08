# Tags the animal for despawn depending on its distance to the nearest player

function mob_dash:game/animals/unbatch_animal

execute if entity @p[distance=..63] run return run function mob_dash:game/animals/despawn/process_0_63_dist
execute if entity @p[distance=..127] run return run function mob_dash:game/animals/despawn/process_64_127_dist
function mob_dash:game/animals/despawn/process_128_plus_dist