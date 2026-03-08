# 'Despawn' the current animal by teleporting it to y-200 under the nearest player, then kill it
# This is to deal with animals that are outside of entity ticking chunks, which will not die if killed but will still count towards the mob cap

execute at @p run tp @s ~ -200 ~
#data modify entity @s DeathTime set value 20
kill @s