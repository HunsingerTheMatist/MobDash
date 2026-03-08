#advancement revoke @s only mob_dash:breed_animal

#execute as @e[type=#mob_dash:non_persistent_creatures,distance=..20,tag=!md_persistent] store result score @s md_age_value run data get entity @s Age
#execute as @e[type=#mob_dash:non_persistent_creatures,distance=..20,tag=!md_persistent,scores={md_age_value=1..},limit=2] run function mob_dash:game/creatures/mark_persistent