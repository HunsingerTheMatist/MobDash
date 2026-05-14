# 'Despawn' the current animal by teleporting it to y-200 under the nearest player, then kill it
# This is to deal with animals that are outside of entity ticking chunks, which will not die if killed but will still count towards the mob cap

# Decrement md_animals_nearby for every player whose ±144 box contains @s,
#  balancing the +1 from 'validate_and_summon'. Done before the tp so the
#  iteration uses the animal's pre-despawn position
execute positioned ~-144 -200 ~-144 as @a[predicate=mob_dash:tracked_player,dx=287,dy=1000,dz=287] run scoreboard players remove @s md_animals_nearby 1

execute at @p run tp @s ~ -200 ~
#data modify entity @s DeathTime set value 20
kill @s
