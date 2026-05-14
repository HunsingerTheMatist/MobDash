# Returns 1 when this animal is not eligible for despawn this cycle, fail
#  otherwise. As a side effect, processes md_despawn_timer: resets it when
#  a player is within ±47, increments it (capped at 30) otherwise. Mirrors
#  vanilla noActionTime > 600 — animals must accumulate ≥ 30 cycles of
#  "no player nearby" before becoming eligible

# If a player is within ±47, reset the despawn timer and return not eligible
execute positioned ~-47 -200 ~-47 if entity @p[predicate=mob_dash:spawn_driver,dx=93,dy=1000,dz=93] \
    run return run scoreboard players reset @s md_despawn_timer

# If no player is within ±160, return not eligible without ticking the timer
execute positioned ~-160 -200 ~-160 unless entity @p[predicate=mob_dash:spawn_driver,dx=319,dy=1000,dz=319] run return 1

# If the despawn timer is below 30, tick it and return not eligible
execute unless score @s md_despawn_timer matches 30.. run return run scoreboard players add @s md_despawn_timer 1

# Past the grace window — eligible to despawn
return fail
