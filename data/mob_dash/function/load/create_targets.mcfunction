# Create target markers (auto-generated file)

summon marker ~ ~ ~ {CustomName:"Bee",              data: {level: 1, weight: 3}, Tags:[md_target, md_bee]}
summon marker ~ ~ ~ {CustomName:"Chicken",          data: {level: 1, weight: 5}, Tags:[md_target, md_chicken]}
summon marker ~ ~ ~ {CustomName:"Cod",              data: {level: 1, weight: 5}, Tags:[md_target, md_cod]}
summon marker ~ ~ ~ {CustomName:"Cow",              data: {level: 1, weight: 5}, Tags:[md_target, md_cow]}
summon marker ~ ~ ~ {CustomName:"Dolphin",          data: {level: 1, weight: 2}, Tags:[md_target, md_dolphin]}
summon marker ~ ~ ~ {CustomName:"Horse",            data: {level: 1, weight: 3}, Tags:[md_target, md_horse]}
summon marker ~ ~ ~ {CustomName:"Nautilus",         data: {level: 1, weight: 3}, Tags:[md_target, md_nautilus]}
summon marker ~ ~ ~ {CustomName:"Pig",              data: {level: 1, weight: 5}, Tags:[md_target, md_pig]}
summon marker ~ ~ ~ {CustomName:"Rabbit",           data: {level: 1, weight: 1}, Tags:[md_target, md_rabbit]}
summon marker ~ ~ ~ {CustomName:"Salmon",           data: {level: 1, weight: 5}, Tags:[md_target, md_salmon]}
summon marker ~ ~ ~ {CustomName:"Sheep",            data: {level: 1, weight: 5}, Tags:[md_target, md_sheep]}
summon marker ~ ~ ~ {CustomName:"Squid",            data: {level: 1, weight: 5}, Tags:[md_target, md_squid]}
summon marker ~ ~ ~ {CustomName:"Turtle",           data: {level: 1, weight: 2}, Tags:[md_target, md_turtle]}

summon marker ~ ~ ~ {CustomName:"Creeper",          data: {level: 2, weight: 5}, Tags:[md_target, md_hostile, md_night, md_creeper]}
summon marker ~ ~ ~ {CustomName:"Drowned",          data: {level: 2, weight: 5}, Tags:[md_target, md_hostile, md_night, md_drowned]}
summon marker ~ ~ ~ {CustomName:"Skeleton",         data: {level: 2, weight: 5}, Tags:[md_target, md_hostile, md_night, md_skeleton]}
summon marker ~ ~ ~ {CustomName:"Spider",           data: {level: 2, weight: 5}, Tags:[md_target, md_hostile, md_night, md_spider]}
summon marker ~ ~ ~ {CustomName:"Zombie",           data: {level: 2, weight: 5}, Tags:[md_target, md_hostile, md_night, md_zombie]}

summon marker ~ ~ ~ {CustomName:"Armadillo",        data: {level: 3, weight: 1}, Tags:[md_target, md_armadillo]}
summon marker ~ ~ ~ {CustomName:"Axolotl",          data: {level: 3, weight: 2}, Tags:[md_target, md_axolotl]}
summon marker ~ ~ ~ {CustomName:"Bat",              data: {level: 3, weight: 1}, Tags:[md_target, md_bat]}
summon marker ~ ~ ~ {CustomName:"Copper Golem",     data: {level: 3, weight: 4}, Tags:[md_target, md_copper_golem]}
summon marker ~ ~ ~ {CustomName:"Fox",              data: {level: 3, weight: 2}, Tags:[md_target, md_fox]}
summon marker ~ ~ ~ {CustomName:"Frog",             data: {level: 3, weight: 1}, Tags:[md_target, md_frog]}
summon marker ~ ~ ~ {CustomName:"Glow Squid",       data: {level: 3, weight: 2}, Tags:[md_target, md_glow_squid]}
summon marker ~ ~ ~ {CustomName:"Goat",             data: {level: 3, weight: 1}, Tags:[md_target, md_goat]}
summon marker ~ ~ ~ {CustomName:"Iron Golem",       data: {level: 3, weight: 3}, Tags:[md_target, md_iron_golem]}
summon marker ~ ~ ~ {CustomName:"Llama",            data: {level: 3, weight: 1}, Tags:[md_target, md_llama]}
summon marker ~ ~ ~ {CustomName:"Polar Bear",       data: {level: 3, weight: 2}, Tags:[md_target, md_polar_bear]}
summon marker ~ ~ ~ {CustomName:"Snow Golem",       data: {level: 3, weight: 3}, Tags:[md_target, md_snow_golem]}
summon marker ~ ~ ~ {CustomName:"Tropical Fish",    data: {level: 3, weight: 1}, Tags:[md_target, md_tropical_fish]}
summon marker ~ ~ ~ {CustomName:"Wolf",             data: {level: 3, weight: 2}, Tags:[md_target, md_wolf]}
summon marker ~ ~ ~ {CustomName:"Enderman",         data: {level: 3, weight: 4}, Tags:[md_target, md_hostile, md_night, md_enderman]}
summon marker ~ ~ ~ {CustomName:"Witch",            data: {level: 3, weight: 2}, Tags:[md_target, md_hostile, md_night, md_witch]}
summon marker ~ ~ ~ {CustomName:"Strider",          data: {level: 3, weight: 5}, Tags:[md_target, md_nether, md_strider]}
summon marker ~ ~ ~ {CustomName:"Ghast",            data: {level: 3, weight: 4}, Tags:[md_target, md_hostile, md_nether, md_ghast]}
summon marker ~ ~ ~ {CustomName:"Hoglin",           data: {level: 3, weight: 5}, Tags:[md_target, md_hostile, md_nether, md_hoglin]}
summon marker ~ ~ ~ {CustomName:"Magma Cube",       data: {level: 3, weight: 3}, Tags:[md_target, md_hostile, md_nether, md_magma_cube]}
summon marker ~ ~ ~ {CustomName:"Piglin",           data: {level: 3, weight: 5}, Tags:[md_target, md_hostile, md_nether, md_piglin]}
summon marker ~ ~ ~ {CustomName:"Zombified Piglin", data: {level: 3, weight: 5}, Tags:[md_target, md_hostile, md_nether, md_zombified_piglin]}

summon marker ~ ~ ~ {CustomName:"Blaze",            data: {level: 4, weight: 3}, Tags:[md_target, md_hostile, md_nether, md_blaze]}
summon marker ~ ~ ~ {CustomName:"Piglin Brute",     data: {level: 4, weight: 2}, Tags:[md_target, md_hostile, md_nether, md_piglin_brute]}
summon marker ~ ~ ~ {CustomName:"Wither Skeleton",  data: {level: 4, weight: 3}, Tags:[md_target, md_hostile, md_nether, md_wither_skeleton]}

execute as @e[distance=..1,type=marker,tag=md_target] store result score @s md_level run data get entity @s data.level
execute as @e[distance=..1,type=marker,tag=md_target] store result score @s md_weight run data get entity @s data.weight
