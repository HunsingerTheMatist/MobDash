# Detect if a target has been killed (auto-generated file)

execute as @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=1}] if entity @a[scores={md_cow=1..}] run tag @s add md_killed
execute if entity @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=1}] as @a[scores={md_cow=1..}] run function mob_dash:game/award_kill
scoreboard players reset * md_cow
execute as @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=2}] if entity @a[scores={md_chicken=1..}] run tag @s add md_killed
execute if entity @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=2}] as @a[scores={md_chicken=1..}] run function mob_dash:game/award_kill
scoreboard players reset * md_chicken
execute as @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=3}] if entity @a[scores={md_pig=1..}] run tag @s add md_killed
execute if entity @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=3}] as @a[scores={md_pig=1..}] run function mob_dash:game/award_kill
scoreboard players reset * md_pig
execute as @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=4}] if entity @a[scores={md_sheep=1..}] run tag @s add md_killed
execute if entity @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=4}] as @a[scores={md_sheep=1..}] run function mob_dash:game/award_kill
scoreboard players reset * md_sheep
execute as @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=5}] if entity @a[scores={md_cod=1..}] run tag @s add md_killed
execute if entity @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=5}] as @a[scores={md_cod=1..}] run function mob_dash:game/award_kill
scoreboard players reset * md_cod
execute as @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=6}] if entity @a[scores={md_salmon=1..}] run tag @s add md_killed
execute if entity @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=6}] as @a[scores={md_salmon=1..}] run function mob_dash:game/award_kill
scoreboard players reset * md_salmon
execute as @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=7}] if entity @a[scores={md_squid=1..}] run tag @s add md_killed
execute if entity @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=7}] as @a[scores={md_squid=1..}] run function mob_dash:game/award_kill
scoreboard players reset * md_squid
execute as @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=8}] if entity @a[scores={md_dolphin=1..}] run tag @s add md_killed
execute if entity @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=8}] as @a[scores={md_dolphin=1..}] run function mob_dash:game/award_kill
scoreboard players reset * md_dolphin
execute as @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=9}] if entity @a[scores={md_bee=1..}] run tag @s add md_killed
execute if entity @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=9}] as @a[scores={md_bee=1..}] run function mob_dash:game/award_kill
scoreboard players reset * md_bee
execute as @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=10}] if entity @a[scores={md_rabbit=1..}] run tag @s add md_killed
execute if entity @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=10}] as @a[scores={md_rabbit=1..}] run function mob_dash:game/award_kill
scoreboard players reset * md_rabbit
execute as @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=11}] if entity @a[scores={md_horse=1..}] run tag @s add md_killed
execute if entity @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=11}] as @a[scores={md_horse=1..}] run function mob_dash:game/award_kill
scoreboard players reset * md_horse
execute as @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=12}] if entity @a[scores={md_bat=1..}] run tag @s add md_killed
execute if entity @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=12}] as @a[scores={md_bat=1..}] run function mob_dash:game/award_kill
scoreboard players reset * md_bat
execute as @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=13}] if entity @a[scores={md_zombie=1..}] run tag @s add md_killed
execute if entity @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=13}] as @a[scores={md_zombie=1..}] run function mob_dash:game/award_kill
scoreboard players reset * md_zombie
execute as @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=14}] if entity @a[scores={md_skeleton=1..}] run tag @s add md_killed
execute if entity @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=14}] as @a[scores={md_skeleton=1..}] run function mob_dash:game/award_kill
scoreboard players reset * md_skeleton
execute as @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=15}] if entity @a[scores={md_creeper=1..}] run tag @s add md_killed
execute if entity @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=15}] as @a[scores={md_creeper=1..}] run function mob_dash:game/award_kill
scoreboard players reset * md_creeper
execute as @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=16}] if entity @a[scores={md_spider=1..}] run tag @s add md_killed
execute if entity @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=16}] as @a[scores={md_spider=1..}] run function mob_dash:game/award_kill
scoreboard players reset * md_spider
execute as @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=17}] if entity @a[scores={md_drowned=1..}] run tag @s add md_killed
execute if entity @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=17}] as @a[scores={md_drowned=1..}] run function mob_dash:game/award_kill
scoreboard players reset * md_drowned
execute as @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=18}] if entity @a[scores={md_enderman=1..}] run tag @s add md_killed
execute if entity @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=18}] as @a[scores={md_enderman=1..}] run function mob_dash:game/award_kill
scoreboard players reset * md_enderman
execute as @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=19}] if entity @a[scores={md_witch=1..}] run tag @s add md_killed
execute if entity @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=19}] as @a[scores={md_witch=1..}] run function mob_dash:game/award_kill
scoreboard players reset * md_witch
execute as @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=20}] if entity @a[scores={md_iron_golem=1..}] run tag @s add md_killed
execute if entity @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=20}] as @a[scores={md_iron_golem=1..}] run function mob_dash:game/award_kill
scoreboard players reset * md_iron_golem
execute as @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=21}] if entity @a[scores={md_guardian=1..}] run tag @s add md_killed
execute if entity @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=21}] as @a[scores={md_guardian=1..}] run function mob_dash:game/award_kill
scoreboard players reset * md_guardian
execute as @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=22}] if entity @a[scores={md_piglin=1..}] run tag @s add md_killed
execute if entity @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=22}] as @a[scores={md_piglin=1..}] run function mob_dash:game/award_kill
scoreboard players reset * md_piglin
execute as @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=23}] if entity @a[scores={md_hoglin=1..}] run tag @s add md_killed
execute if entity @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=23}] as @a[scores={md_hoglin=1..}] run function mob_dash:game/award_kill
scoreboard players reset * md_hoglin
execute as @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=24}] if entity @a[scores={md_ghast=1..}] run tag @s add md_killed
execute if entity @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=24}] as @a[scores={md_ghast=1..}] run function mob_dash:game/award_kill
scoreboard players reset * md_ghast
execute as @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=25}] if entity @a[scores={md_strider=1..}] run tag @s add md_killed
execute if entity @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=25}] as @a[scores={md_strider=1..}] run function mob_dash:game/award_kill
scoreboard players reset * md_strider
execute as @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=26}] if entity @a[scores={md_magma_cube=1..}] run tag @s add md_killed
execute if entity @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=26}] as @a[scores={md_magma_cube=1..}] run function mob_dash:game/award_kill
scoreboard players reset * md_magma_cube
execute as @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=27}] if entity @a[scores={md_zombified_pi=1..}] run tag @s add md_killed
execute if entity @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=27}] as @a[scores={md_zombified_pi=1..}] run function mob_dash:game/award_kill
scoreboard players reset * md_zombified_pi
execute as @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=28}] if entity @a[scores={md_llama=1..}] run tag @s add md_killed
execute if entity @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=28}] as @a[scores={md_llama=1..}] run function mob_dash:game/award_kill
scoreboard players reset * md_llama
execute as @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=29}] if entity @a[scores={md_goat=1..}] run tag @s add md_killed
execute if entity @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=29}] as @a[scores={md_goat=1..}] run function mob_dash:game/award_kill
scoreboard players reset * md_goat
execute as @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=30}] if entity @a[scores={md_axolotl=1..}] run tag @s add md_killed
execute if entity @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=30}] as @a[scores={md_axolotl=1..}] run function mob_dash:game/award_kill
scoreboard players reset * md_axolotl
execute as @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=31}] if entity @a[scores={md_glow_squid=1..}] run tag @s add md_killed
execute if entity @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=31}] as @a[scores={md_glow_squid=1..}] run function mob_dash:game/award_kill
scoreboard players reset * md_glow_squid
execute as @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=32}] if entity @a[scores={md_zoglin=1..}] run tag @s add md_killed
execute if entity @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=32}] as @a[scores={md_zoglin=1..}] run function mob_dash:game/award_kill
scoreboard players reset * md_zoglin
execute as @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=33}] if entity @a[scores={md_blaze=1..}] run tag @s add md_killed
execute if entity @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=33}] as @a[scores={md_blaze=1..}] run function mob_dash:game/award_kill
scoreboard players reset * md_blaze
execute as @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=34}] if entity @a[scores={md_wither_skele=1..}] run tag @s add md_killed
execute if entity @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=34}] as @a[scores={md_wither_skele=1..}] run function mob_dash:game/award_kill
scoreboard players reset * md_wither_skele
execute as @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=35}] if entity @a[scores={md_piglin_brute=1..}] run tag @s add md_killed
execute if entity @e[type=minecraft:area_effect_cloud,tag=md_selected,scores={md_target=35}] as @a[scores={md_piglin_brute=1..}] run function mob_dash:game/award_kill
scoreboard players reset * md_piglin_brute
