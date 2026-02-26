# Create target data (auto-generated file)

summon marker ~ ~ ~ {CustomName:"Bee", data: {level: 1, weight: 3}, Tags:[md_target]}
summon marker ~ ~ ~ {CustomName:"Chicken", data: {level: 1, weight: 5}, Tags:[md_target]}
summon marker ~ ~ ~ {CustomName:"Cod", data: {level: 1, weight: 5}, Tags:[md_target]}
summon marker ~ ~ ~ {CustomName:"Cow", data: {level: 1, weight: 5}, Tags:[md_target]}
summon marker ~ ~ ~ {CustomName:"Dolphin", data: {level: 1, weight: 5}, Tags:[md_target]}
summon marker ~ ~ ~ {CustomName:"Horse", data: {level: 1, weight: 3}, Tags:[md_target]}
summon marker ~ ~ ~ {CustomName:"Pig", data: {level: 1, weight: 5}, Tags:[md_target]}
summon marker ~ ~ ~ {CustomName:"Rabbit", data: {level: 1, weight: 2}, Tags:[md_target]}
summon marker ~ ~ ~ {CustomName:"Salmon", data: {level: 1, weight: 5}, Tags:[md_target]}
summon marker ~ ~ ~ {CustomName:"Sheep", data: {level: 1, weight: 5}, Tags:[md_target]}
summon marker ~ ~ ~ {CustomName:"Squid", data: {level: 1, weight: 5}, Tags:[md_target]}

summon marker ~ ~ ~ {CustomName:"Bat", data: {level: 2, weight: 2}, Tags:[md_target]}
summon marker ~ ~ ~ {CustomName:"Creeper", data: {level: 2, weight: 5}, Tags:[md_target, md_hostile, md_night]}
summon marker ~ ~ ~ {CustomName:"Drowned", data: {level: 2, weight: 5}, Tags:[md_target, md_hostile, md_night]}
summon marker ~ ~ ~ {CustomName:"Skeleton", data: {level: 2, weight: 5}, Tags:[md_target, md_hostile, md_night]}
summon marker ~ ~ ~ {CustomName:"Spider", data: {level: 2, weight: 5}, Tags:[md_target, md_hostile, md_night]}
summon marker ~ ~ ~ {CustomName:"Zombie", data: {level: 2, weight: 5}, Tags:[md_target, md_hostile, md_night]}

summon marker ~ ~ ~ {CustomName:"Axolotl", data: {level: 3, weight: 2}, Tags:[md_target]}
summon marker ~ ~ ~ {CustomName:"Enderman", data: {level: 3, weight: 5}, Tags:[md_target, md_hostile, md_night]}
summon marker ~ ~ ~ {CustomName:"Ghast", data: {level: 3, weight: 4}, Tags:[md_target, md_hostile, md_nether]}
summon marker ~ ~ ~ {CustomName:"Glow Squid", data: {level: 3, weight: 2}, Tags:[md_target]}
summon marker ~ ~ ~ {CustomName:"Goat", data: {level: 3, weight: 1}, Tags:[md_target]}
summon marker ~ ~ ~ {CustomName:"Guardian", data: {level: 3, weight: 1}, Tags:[md_target, md_hostile]}
summon marker ~ ~ ~ {CustomName:"Hoglin", data: {level: 3, weight: 5}, Tags:[md_target, md_hostile, md_nether]}
summon marker ~ ~ ~ {CustomName:"Iron Golem", data: {level: 3, weight: 3}, Tags:[md_target]}
summon marker ~ ~ ~ {CustomName:"Llama", data: {level: 3, weight: 1}, Tags:[md_target]}
summon marker ~ ~ ~ {CustomName:"Magma Cube", data: {level: 3, weight: 3}, Tags:[md_target, md_hostile, md_nether]}
summon marker ~ ~ ~ {CustomName:"Piglin", data: {level: 3, weight: 5}, Tags:[md_target, md_hostile, md_nether]}
summon marker ~ ~ ~ {CustomName:"Strider", data: {level: 3, weight: 5}, Tags:[md_target, md_nether]}
summon marker ~ ~ ~ {CustomName:"Witch", data: {level: 3, weight: 2}, Tags:[md_target, md_hostile, md_night]}
summon marker ~ ~ ~ {CustomName:"Zombified Piglin", data: {level: 3, weight: 5}, Tags:[md_target, md_hostile, md_nether]}

summon marker ~ ~ ~ {CustomName:"Blaze", data: {level: 4, weight: 3}, Tags:[md_target, md_hostile, md_nether]}
summon marker ~ ~ ~ {CustomName:"Piglin Brute", data: {level: 4, weight: 2}, Tags:[md_target, md_hostile, md_nether]}
summon marker ~ ~ ~ {CustomName:"Wither Skeleton", data: {level: 4, weight: 3}, Tags:[md_target, md_hostile, md_nether]}
summon marker ~ ~ ~ {CustomName:"Zoglin", data: {level: 4, weight: 4}, Tags:[md_target, md_hostile, md_nether]}

execute as @e[distance=..1,type=marker,tag=md_target] store result score @s md_level run data get entity @s data.level
execute as @e[distance=..1,type=marker,tag=md_target] store result score @s md_weight run data get entity @s data.weight