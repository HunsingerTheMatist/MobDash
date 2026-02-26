# Set the world border

execute unless entity @n[type=marker,tag=md_spawn] run summon marker ~ ~ ~ {Tags:[md_spawn]}
forceload add ~ ~

worldborder center ~ ~
spawnpoint @a ~ ~ ~
setworldspawn ~ ~ ~
worldborder set 100

scoreboard players set $SpawnSetupDone md_state 1