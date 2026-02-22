# Stores various text components in storage for future use

# The "[X]" shown at the end of each line in the tutorial
execute unless data storage mob_dash:data CancelTutorialButton run data modify storage mob_dash:data CancelTutorialButton set value [ \
    {text:" [", color:gold, bold: true}, \
    {text:"X", color:green, \
        hover_event: {action:show_text, value: {text:"Cancel Tutorial"}}, \
        click_event: {action:run_command, command:"trigger MenuAction set 1"}}, \
    {text:"]", color:gold, bold: true} \
]

# The "Cow (2 Points)" messages shown in the action bar for each target
execute unless data storage mob_dash:data ActionBarTarget1 run data modify storage mob_dash:data ActionBarTarget1 set value [ \
    {selector:"@n[distance=0,type=marker,tag=md_selected1]", color:red}, \
    {text:" (", color:gold}, \
    {score: {objective:md_score, name:"@n[distance=0,type=marker,tag=md_selected1]"}, color:gold}, \
    {storage:"mob_dash:data", nbt:PointStringMob1, color:gold}, \
    {text:")", color:gold} \
]
execute unless data storage mob_dash:data ActionBarTarget2 run data modify storage mob_dash:data ActionBarTarget2 set value [ \
    {selector:"@n[distance=0,type=marker,tag=md_selected2]", color:red}, \
    {text:" (", color:gold}, \
    {score: {objective:md_score, name:"@n[distance=0,type=marker,tag=md_selected2]"}, color:gold}, \
    {storage:"mob_dash:data", nbt:PointStringMob2, color:gold}, \
    {text:")", color:gold} \
]
execute unless data storage mob_dash:data ActionBarTarget3 run data modify storage mob_dash:data ActionBarTarget3 set value [ \
    {selector:"@n[distance=0,type=marker,tag=md_selected3]", color:red}, \
    {text:" (", color:gold}, \
    {score: {objective:md_score, name:"@n[distance=0,type=marker,tag=md_selected3]"}, color:gold}, \
    {storage:"mob_dash:data", nbt:PointStringMob3, color:gold}, \
    {text:")", color:gold} \
]