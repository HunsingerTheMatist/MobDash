# Updates debug glow visualization for the current animal
# When animal debug mode is enabled, persistent animals glow blue

execute if entity @s[tag=!md_persistent] run return run data modify entity @s Glowing set value false

data modify entity @s Glowing set value true
team join blue @s
