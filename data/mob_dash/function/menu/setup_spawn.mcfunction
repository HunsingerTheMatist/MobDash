# Set the world border

execute if block ~ ~-1 ~ #air positioned ~ ~-1 ~ run return run function mob_dash:menu/setup_spawn

execute unless entity @n[distance=0..,type=marker,tag=md_spawn] run summon marker ~ ~ ~ {Tags:[md_spawn]}
forceload add ~ ~

tp @a ~ ~ ~
worldborder center ~ ~
spawnpoint @a ~ ~ ~
setworldspawn ~ ~ ~
worldborder set 100

scoreboard players set $SpawnSetupDone md_state 1