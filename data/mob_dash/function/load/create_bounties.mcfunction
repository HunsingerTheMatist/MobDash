# Create bounty markers (auto-generated file)

summon marker ~ ~ ~ {CustomName:"Mooshroom",              data: {weight: 2, min_score: 10, max_score: 15}, Tags:[md_bounty, md_mooshroom]}
summon marker ~ ~ ~ {CustomName:"Panda",                  data: {weight: 1, min_score: 10, max_score: 14}, Tags:[md_bounty, md_panda]}
summon marker ~ ~ ~ {CustomName:"Warden",                 data: {weight: 4, min_score: 20, max_score: 30}, Tags:[md_bounty, md_hostile, md_warden]}
summon marker ~ ~ ~ {CustomName:"Creaking",               data: {weight: 2, min_score: 17, max_score: 22}, Tags:[md_bounty, md_hostile, md_night, md_creaking]}
summon marker ~ ~ ~ {CustomName:"Zoglin",                 data: {weight: 4, min_score: 17, max_score: 20}, Tags:[md_bounty, md_hostile, md_nether, md_zoglin]}
summon marker ~ ~ ~ {CustomName:"Camel Husk Jockey",      data: {weight: 1, min_score: 18, max_score: 24}, Tags:[md_bounty, md_hostile, md_night, md_camel_husk_jockey]}
summon marker ~ ~ ~ {CustomName:"Chicken Jockey",         data: {weight: 5, min_score: 12, max_score: 17}, Tags:[md_bounty, md_hostile, md_night, md_chicken_jockey]}
summon marker ~ ~ ~ {CustomName:"Spider Jockey",          data: {weight: 4, min_score: 14, max_score: 18}, Tags:[md_bounty, md_hostile, md_night, md_spider_jockey]}
summon marker ~ ~ ~ {CustomName:"Zombie Horseman",        data: {weight: 3, min_score: 13, max_score: 17}, Tags:[md_bounty, md_hostile, md_night, md_zombie_horseman]}
summon marker ~ ~ ~ {CustomName:"Zombie Nautilus Jockey", data: {weight: 2, min_score: 18, max_score: 25}, Tags:[md_bounty, md_hostile, md_night, md_zombie_nautilus_jockey]}
summon marker ~ ~ ~ {CustomName:"Invisible Spider",       data: {weight: 2, min_score: 15, max_score: 20}, Tags:[md_bounty, md_hostile, md_night, md_invisible_spider]}
summon marker ~ ~ ~ {CustomName:"Strider Jockey",         data: {weight: 4, min_score: 10, max_score: 12}, Tags:[md_bounty, md_nether, md_strider_jockey]}

execute as @e[distance=..1,type=marker,tag=md_bounty] store result score @s md_weight run data get entity @s data.weight
execute as @e[distance=..1,type=marker,tag=md_bounty] store result score @s md_min_score run data get entity @s data.min_score
execute as @e[distance=..1,type=marker,tag=md_bounty] store result score @s md_max_score run data get entity @s data.max_score