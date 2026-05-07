# Relocates the spawnpoint to a new random location

scoreboard players set $BorderCooldown md_state 0

title @a title "Teleporting In:"

worldborder set 50000

function mob_dash:menu/relocate_players
