# Count all animals nearby that currently don't count towards the cap

# Count all permanently persistent animals nearby
execute store result score @s md_player_cap if entity @e[type=#mob_dash:animals,distance=..160,tag=md_persistent]

# Include temporarily persistent animals in the count
execute store result score #temp md_state if entity @e[type=#mob_dash:non_persistent_animals,distance=..160,tag=!md_persistent,tag=md_temp_persistent]
scoreboard players operation @s md_player_cap += #temp md_state

# Update passenger tags
tag @e[type=#mob_dash:non_persistent_animals,distance=..160,tag=md_has_or_is_passenger] remove md_has_or_is_passenger
tag @e[type=#mob_dash:non_persistent_animals,distance=..160,tag=!md_persistent,predicate=mob_dash:has_or_is_passenger] add md_has_or_is_passenger

# Include animals that have or are passengers in the count
execute store result score #temp md_state if entity @e[type=#mob_dash:non_persistent_animals,distance=..160,tag=!md_persistent,tag=!md_temp_persistent,tag=md_has_or_is_passenger]
scoreboard players operation @s md_player_cap += #temp md_state