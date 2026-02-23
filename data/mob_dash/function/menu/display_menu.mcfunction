# Display the menu

function mob_dash:menu/welcome

# - [Tutorial]
# - [Switch Teams]
# - [Relocate Spawn]
#
# - [Op-Only Mode: Off]
# - [Win Score Limit: None]
# - [Time Limit: None]
# - [Difficulty Scaling: Normal]
# - [Points Increase Every: 1 min]
# - [Passive-only Start: Off]
# - [Hostiles: On]
# - [Nether: On]
#
# - [Start Game]

tellraw @s \
[ \
    {text:"\n"}, \
    {text:"- "}, {text:"[", color:gold, bold: true}, {text:"Tutorial",       color:green, click_event: {action:run_command, command:"trigger MenuAction set 1"}}, {text:"]\n", color:gold, bold: true}, \
    {text:"- "}, {text:"[", color:gold, bold: true}, {text:"Switch Teams",   color:green, click_event: {action:run_command, command:"trigger MenuAction set 3"}}, {text:"]\n", color:gold, bold: true}, \
    {text:"- "}, {text:"[", color:gold, bold: true}, {text:"Relocate Spawn", color:green, click_event: {action:run_command, command:"function mob_dash:menu/relocate_spawn"}}, {text:"]\n", color:gold, bold: true}, \
]

# If Op-Only Mode is off, show all players the 'Op-Only Mode' toggle
# If Op-Only Mode is on, only show the toggle to op-ed players, and for the others show an authenticate option
execute if score $OpOnly md_state matches 0 run tellraw @s \
    [{text:"- "}, {text:"[", color:gold, bold: true}, {text:"Op-Only Mode: ", color:green, extra: [{storage:"mob_dash:data", nbt:OpOnlyMode, color:aqua}], click_event: {action:run_command, command:"function mob_dash:menu/settings/cycle_op_only"}}, {text:"]", color:gold, bold: true}]
execute unless score $OpOnly md_state matches 0 run tellraw @s[tag=md_op] \
    [{text:"- "}, {text:"[", color:gold, bold: true}, {text:"Op-Only Mode: ", color:green, extra: [{storage:"mob_dash:data", nbt:"OpOnlyMode", color:aqua}], click_event: {action:run_command, command:"function mob_dash:menu/settings/cycle_op_only"}}, {text:"]", color:gold, bold: true}]
execute unless score $OpOnly md_state matches 0 run tellraw @s[tag=!md_op] \
    [{text:"- "}, {text:"[", color:gold, bold: true}, {text:"Sign-In as Op: ", color:green, click_event: {action:run_command, command:"function mob_dash:menu/op_auth"}}, {text:"]", color:gold, bold: true}]

tellraw @s \
[ \
    {text:"- "}, {text:"[", color:gold, bold: true}, {text:"Win Score Limit: ",       color:green, extra: [{storage:"mob_dash:data", nbt:"WinScore",        color:aqua}], click_event: {action:suggest_command, command:"/trigger WinScore set "}}, {text:"]\n", color:gold, bold: true}, \
    {text:"- "}, {text:"[", color:gold, bold: true}, {text:"Time Limit: ",            color:green, extra: [{storage:"mob_dash:data", nbt:"TimeLimit",       color:aqua}], click_event: {action:suggest_command, command:"/trigger TimeLimit set "}}, {text:"]\n", color:gold, bold: true}, \
    {text:"- "}, {text:"[", color:gold, bold: true}, {text:"Difficulty Scaling: ",    color:green, extra: [{storage:"mob_dash:data", nbt:"DifficultySpeed", color:aqua}], click_event: {action:run_command, command:"trigger MenuAction set 11"}}, {text:"]\n", color:gold, bold: true}, \
    {text:"- "}, {text:"[", color:gold, bold: true}, {text:"Points Increase Every: ", color:green, extra: [{storage:"mob_dash:data", nbt:"IncrementPeriod", color:aqua}], click_event: {action:run_command, command:"trigger MenuAction set 12"}}, {text:"]\n", color:gold, bold: true}, \
    {text:"- "}, {text:"[", color:gold, bold: true}, {text:"Passive-only Start: ",    color:green, extra: [{storage:"mob_dash:data", nbt:"PassiveStart",    color:aqua}], click_event: {action:run_command, command:"trigger MenuAction set 13"}}, {text:"]\n", color:gold, bold: true}, \
    {text:"- "}, {text:"[", color:gold, bold: true}, {text:"Hostiles: ",              color:green, extra: [{storage:"mob_dash:data", nbt:"Hostiles",        color:aqua}], click_event: {action:run_command, command:"trigger MenuAction set 14"}}, {text:"]\n", color:gold, bold: true}, \
    {text:"- "}, {text:"[", color:gold, bold: true}, {text:"Nether: ",                color:green, extra: [{storage:"mob_dash:data", nbt:"Nether",          color:aqua}], click_event: {action:run_command, command:"trigger MenuAction set 15"}}, {text:"]\n", color:gold, bold: true}, \
    {text:"\n"}, \
    {text:"- "}, {text:"[", color:gold, bold: true}, {text:"Start Game",              color:green, click_event: {action:run_command, command:"trigger MenuAction set 20"}}, {text:"]", color:gold, bold: true} \
]

scoreboard players set @s md_menu_ticks 0