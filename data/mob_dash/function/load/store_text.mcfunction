# Stores various text components in storage for future use

# The "[X]" shown at the end of each line in the tutorial
data modify storage mob_dash:data Templates.CancelTutorialButton set value [ \
    {text:" [", color:gold, bold: true}, \
    {text:"X", color:green, \
        hover_event: {action:show_text, value: {text:"Cancel Tutorial"}}, \
        click_event: {action:run_command, command:"trigger MenuAction set 2"}}, \
    {text:"]", color:gold, bold: true} \
]

# The "Cow (2 points)" messages shown in the action bar for each target
# Contains placeholder text at indexes 0, 2, and 3 that needs to be replaced with the target's actual values
data modify storage mob_dash:data Templates.ActionBarTarget set value [ \
    {text:NAME, color:red}, \
    {text:" (", color:gold}, \
    {text:SCORE, color:gold}, \
    {text:POINTS_STRING, color:gold}, \
    {text:")", color:gold} \
]