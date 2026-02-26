# Counts down to the teleport, then performs it after 3 seconds

scoreboard players add $BorderCooldown md_state 1

execute if score $BorderCooldown md_state matches 1 run title @a subtitle "3"
execute if score $BorderCooldown md_state matches 2 run title @a subtitle "2"
execute if score $BorderCooldown md_state matches 3 run title @a subtitle "1"

execute if score $BorderCooldown md_state matches ..3 run return run schedule function mob_dash:menu/relocate_players 1s

execute if score $BorderCooldown md_state matches 5 at @n[type=marker,tag=md_spawn] run return run function mob_dash:menu/setup_spawn

# Spread a random player out, then teleport all other players & spawn marker to them
tag @p add md_current
forceload remove ~ ~
spreadplayers ~ ~ 0 5000 false @p[tag=md_current]
execute unless entity @n[type=marker,tag=md_spawn] at @p[tag=md_current] run summon marker ~ ~ ~ {Tags:[md_spawn]}
tp @n[type=marker,tag=md_spawn] @p[tag=md_current]
tp @a @p[tag=md_current]
tag @p[tag=md_current] remove md_current

schedule function mob_dash:menu/relocate_players 1s