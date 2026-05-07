# Sets up the menu spawn point at the current position. Callers are responsible
#  for snapping to ground via `execute positioned over motion_blocking_no_leaves`.

execute unless entity @n[distance=0..,type=marker,tag=md_spawn] run summon marker ~ ~ ~ {Tags:[md_spawn]}
tp @n[distance=0..,type=marker,tag=md_spawn] ~ ~ ~
forceload add ~ ~

tp @a ~ ~ ~
worldborder center ~ ~
spawnpoint @a ~ ~ ~
setworldspawn ~ ~ ~
worldborder set 100
