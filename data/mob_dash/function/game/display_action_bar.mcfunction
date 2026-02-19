# Display the action bar

# Only needs to be displayed every 40 ticks unless invalidated elsewhere
scoreboard players set $ActionBarTick md_state 40

# Case for 1, 2, or 3 selected mobs
execute if score $TargetCount md_state matches 1 run return run title @a actionbar \
[\
    {"text":"Target: ","color":"gold"}, \
    \
    {"selector":"@n[type=marker,tag=md_selected1]","color":"red"}, \
    {"text": " (", "color":"gold"}, \
    {"score": {"name": "@n[type=marker,tag=md_selected1]", "objective": "md_score"}, "color":"gold"}, \
    {"storage": "mob_dash:data", nbt: "PointStringMob1", "color":"gold"}, \
    {"text": ")", "color":"gold"}, \
]

execute if score $TargetCount md_state matches 2 run return run title @a actionbar \
[\
    {"text":"Targets: ","color":"gold"}, \
    \
    {"selector":"@n[type=marker,tag=md_selected1]","color":"red"}, \
    {"text": " (", "color":"gold"}, \
    {"score": {"name": "@n[type=marker,tag=md_selected1]", "objective": "md_score"}, "color":"gold"}, \
    {"storage": "mob_dash:data", nbt: "PointStringMob1", "color":"gold"}, \
    {"text": "), ", "color":"gold"}, \
    \
    {"selector":"@n[type=marker,tag=md_selected2]","color":"red"}, \
    {"text": " (", "color":"gold"}, \
    {"score": {"name": "@n[type=marker,tag=md_selected2]", "objective": "md_score"}, "color":"gold"}, \
    {"storage": "mob_dash:data", nbt: "PointStringMob2", "color":"gold"}, \
    {"text": ")", "color":"gold"}, \
]

title @a actionbar \
[\
    {"text":"Targets: ","color":"gold"}, \
    \
    {"selector":"@n[type=marker,tag=md_selected1]","color":"red"}, \
    {"text": " (", "color":"gold"}, \
    {"score": {"name": "@n[type=marker,tag=md_selected1]", "objective": "md_score"}, "color":"gold"}, \
    {"storage": "mob_dash:data", nbt: "PointStringMob1", "color":"gold"}, \
    {"text": "), ", "color":"gold"}, \
    \
    {"selector":"@n[type=marker,tag=md_selected2]","color":"red"}, \
    {"text": " (", "color":"gold"}, \
    {"score": {"name": "@n[type=marker,tag=md_selected2]", "objective": "md_score"}, "color":"gold"}, \
    {"storage": "mob_dash:data", nbt: "PointStringMob2", "color":"gold"}, \
    {"text": "), ", "color":"gold"}, \
    \
    {"selector":"@n[type=marker,tag=md_selected3]","color":"red"}, \
    {"text": " (", "color":"gold"}, \
    {"score": {"name": "@n[type=marker,tag=md_selected3]", "objective": "md_score"}, "color":"gold"}, \
    {"storage": "mob_dash:data", nbt: "PointStringMob3", "color":"gold"}, \
    {"text": ")", "color":"gold"} \
]