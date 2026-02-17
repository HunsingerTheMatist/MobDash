# Create target data (auto-generated file)

summon marker 0 0 0 {CustomName:"Bee", data:{"level": 1, "weight": 3}, Tags:["md_target"]}
summon marker 0 0 0 {CustomName:"Chicken", data:{"level": 1, "weight": 5}, Tags:["md_target"]}
summon marker 0 0 0 {CustomName:"Cod", data:{"level": 1, "weight": 5}, Tags:["md_target"]}
summon marker 0 0 0 {CustomName:"Cow", data:{"level": 1, "weight": 5}, Tags:["md_target"]}
summon marker 0 0 0 {CustomName:"Dolphin", data:{"level": 1, "weight": 5}, Tags:["md_target"]}
summon marker 0 0 0 {CustomName:"Horse", data:{"level": 1, "weight": 3}, Tags:["md_target"]}
summon marker 0 0 0 {CustomName:"Pig", data:{"level": 1, "weight": 5}, Tags:["md_target"]}
summon marker 0 0 0 {CustomName:"Rabbit", data:{"level": 1, "weight": 2}, Tags:["md_target"]}
summon marker 0 0 0 {CustomName:"Salmon", data:{"level": 1, "weight": 5}, Tags:["md_target"]}
summon marker 0 0 0 {CustomName:"Sheep", data:{"level": 1, "weight": 5}, Tags:["md_target"]}
summon marker 0 0 0 {CustomName:"Squid", data:{"level": 1, "weight": 5}, Tags:["md_target"]}

summon marker 0 0 0 {CustomName:"Bat", data:{"level": 2, "weight": 2}, Tags:["md_target"]}
summon marker 0 0 0 {CustomName:"Creeper", data:{"level": 2, "weight": 5}, Tags:["md_target","md_hostile","md_night"]}
summon marker 0 0 0 {CustomName:"Drowned", data:{"level": 2, "weight": 5}, Tags:["md_target","md_hostile","md_night"]}
summon marker 0 0 0 {CustomName:"Skeleton", data:{"level": 2, "weight": 5}, Tags:["md_target","md_hostile","md_night"]}
summon marker 0 0 0 {CustomName:"Spider", data:{"level": 2, "weight": 5}, Tags:["md_target","md_hostile","md_night"]}
summon marker 0 0 0 {CustomName:"Zombie", data:{"level": 2, "weight": 5}, Tags:["md_target","md_hostile","md_night"]}

summon marker 0 0 0 {CustomName:"Axolotl", data:{"level": 3, "weight": 2}, Tags:["md_target"]}
summon marker 0 0 0 {CustomName:"Enderman", data:{"level": 3, "weight": 5}, Tags:["md_target","md_hostile","md_night"]}
summon marker 0 0 0 {CustomName:"Ghast", data:{"level": 3, "weight": 4}, Tags:["md_target","md_hostile","md_nether"]}
summon marker 0 0 0 {CustomName:"Glow Squid", data:{"level": 3, "weight": 2}, Tags:["md_target"]}
summon marker 0 0 0 {CustomName:"Goat", data:{"level": 3, "weight": 1}, Tags:["md_target"]}
summon marker 0 0 0 {CustomName:"Guardian", data:{"level": 3, "weight": 1}, Tags:["md_target","md_hostile"]}
summon marker 0 0 0 {CustomName:"Hoglin", data:{"level": 3, "weight": 5}, Tags:["md_target","md_hostile","md_nether"]}
summon marker 0 0 0 {CustomName:"Iron Golem", data:{"level": 3, "weight": 3}, Tags:["md_target"]}
summon marker 0 0 0 {CustomName:"Llama", data:{"level": 3, "weight": 1}, Tags:["md_target"]}
summon marker 0 0 0 {CustomName:"Magma Cube", data:{"level": 3, "weight": 3}, Tags:["md_target","md_hostile","md_nether"]}
summon marker 0 0 0 {CustomName:"Piglin", data:{"level": 3, "weight": 5}, Tags:["md_target","md_hostile","md_nether"]}
summon marker 0 0 0 {CustomName:"Strider", data:{"level": 3, "weight": 5}, Tags:["md_target","md_nether"]}
summon marker 0 0 0 {CustomName:"Witch", data:{"level": 3, "weight": 2}, Tags:["md_target","md_hostile","md_night"]}
summon marker 0 0 0 {CustomName:"Zombified Piglin", data:{"level": 3, "weight": 5}, Tags:["md_target","md_hostile","md_nether"]}

summon marker 0 0 0 {CustomName:"Blaze", data:{"level": 4, "weight": 3}, Tags:["md_target","md_hostile","md_nether"]}
summon marker 0 0 0 {CustomName:"Piglin Brute", data:{"level": 4, "weight": 2}, Tags:["md_target","md_hostile","md_nether"]}
summon marker 0 0 0 {CustomName:"Wither Skeleton", data:{"level": 4, "weight": 3}, Tags:["md_target","md_hostile","md_nether"]}
summon marker 0 0 0 {CustomName:"Zoglin", data:{"level": 4, "weight": 4}, Tags:["md_target","md_hostile","md_nether"]}

execute as @e[type=marker,tag=md_target] store result score @s md_level run data get entity @s data.level
execute as @e[type=marker,tag=md_target] store result score @s md_weight run data get entity @s data.weight