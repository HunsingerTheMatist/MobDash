# Display the menu

function mob_dash:menu/welcome

# - [Tutorial]
# - [Switch Teams]
# - [Randomize Teams]
# - [Relocate Spawn]
#
# - [Op-Only Mode: Off]
# - [Win Score Limit: None]
# - [Time Limit: None]
# - [Difficulty Scaling: Normal]
# - [Points Increase Every: 1 min]
# - [Bounties: On]
# - [Hostiles: Off at Start]
# - [Nether: On]
#
# - [Start Game]

tellraw @s \
[ \
    {text:"\n"}, \
    {text:"- "}, {text:"[", color:gold, bold: true}, {text:"Tutorial",       color:green, click_event: {action:run_command, command:"trigger MenuAction set 1"}}, {text:"]\n", color:gold, bold: true}, \
    {text:"- "}, {text:"[", color:gold, bold: true}, {text:"Switch Teams",   color:green, click_event: {action:run_command, command:"trigger MenuAction set 3"}}, {text:"]\n", color:gold, bold: true}, \
    {text:"- "}, {text:"[", color:gold, bold: true}, {text:"Randomize Teams",   color:green, click_event: {action:suggest_command, command:"/trigger TeamCount set "}}, {text:"]\n", color:gold, bold: true}, \
    {text:"- "}, {text:"[", color:gold, bold: true}, {text:"Relocate Spawn", color:green, click_event: {action:run_command, command:"function mob_dash:menu/relocate_spawn"}}, {text:"]\n", color:gold, bold: true}, \
]

# If Op-Only Mode is off, show all players the 'Op-Only Mode' toggle
# If Op-Only Mode is on, only show the toggle to op-ed players, and for the others show an authenticate option
execute if score $OpOnly md_setting matches 0 run tellraw @s \
    [{text:"- "}, {text:"[", color:gold, bold: true}, {text:"Op-Only Mode: ", color:green, extra: [{storage:"mob_dash:data", nbt:Settings.OpOnlyMode, interpret:true, color:aqua}], click_event: {action:run_command, command:"function mob_dash:menu/settings/cycle_op_only"}}, {text:"]", color:gold, bold: true}]
execute unless score $OpOnly md_setting matches 0 run tellraw @s[tag=md_op] \
    [{text:"- "}, {text:"[", color:gold, bold: true}, {text:"Op-Only Mode: ", color:green, extra: [{storage:"mob_dash:data", nbt:Settings.OpOnlyMode, interpret:true, color:aqua}], click_event: {action:run_command, command:"function mob_dash:menu/settings/cycle_op_only"}}, {text:"]", color:gold, bold: true}]
execute unless score $OpOnly md_setting matches 0 run tellraw @s[tag=!md_op] \
    [{text:"- "}, {text:"[", color:gold, bold: true}, {text:"Sign-In as Op", color:green, click_event: {action:run_command, command:"function mob_dash:menu/op_auth"}}, {text:"]", color:gold, bold: true}]

tellraw @s \
[ \
    {text:"- "}, {text:"[", color:gold, bold: true}, {text:"Win Score Limit: ",       color:green, extra: [{storage:"mob_dash:data", nbt:Settings.WinScore,        interpret:true, color:aqua}], click_event: {action:suggest_command, command:"/trigger WinScore set "}}, {text:"]\n", color:gold, bold: true}, \
    {text:"- "}, {text:"[", color:gold, bold: true}, {text:"Time Limit: ",            color:green, extra: [{storage:"mob_dash:data", nbt:Settings.TimeLimit,       interpret:true, color:aqua}], click_event: {action:suggest_command, command:"/trigger TimeLimit set "}}, {text:"]\n", color:gold, bold: true}, \
    {text:"- "}, {text:"[", color:gold, bold: true}, {text:"Difficulty Scaling: ",    color:green, extra: [{storage:"mob_dash:data", nbt:Settings.DifficultySpeed, interpret:true, color:aqua}], click_event: {action:run_command, command:"trigger MenuAction set 11"}}, {text:"]\n", color:gold, bold: true}, \
    {text:"- "}, {text:"[", color:gold, bold: true}, {text:"Points Increase Every: ", color:green, extra: [{storage:"mob_dash:data", nbt:Settings.IncrementPeriod, interpret:true, color:aqua}], click_event: {action:run_command, command:"trigger MenuAction set 12"}}, {text:"]\n", color:gold, bold: true}, \
    {text:"- "}, {text:"[", color:gold, bold: true}, {text:"Bounties: ",              color:green, extra: [{storage:"mob_dash:data", nbt:Settings.Bounties,        interpret:true, color:aqua}], click_event: {action:run_command, command:"trigger MenuAction set 13"}}, {text:"]\n", color:gold, bold: true}, \
    {text:"- "}, {text:"[", color:gold, bold: true}, {text:"Hostiles: ",              color:green, extra: [{storage:"mob_dash:data", nbt:Settings.Hostiles,        interpret:true, color:aqua}], click_event: {action:run_command, command:"trigger MenuAction set 14"}}, {text:"]\n", color:gold, bold: true}, \
    {text:"- "}, {text:"[", color:gold, bold: true}, {text:"Nether: ",                color:green, extra: [{storage:"mob_dash:data", nbt:Settings.Nether,          interpret:true, color:aqua}], click_event: {action:run_command, command:"trigger MenuAction set 15"}}, {text:"]", color:gold, bold: true}, \
]
tellraw @s \
   [{text:"\n- "}, {text:"[", color:gold, bold: true}, {text:"Start Game", color:green, click_event: {action:run_command, command:"trigger MenuAction set 20"}}, {text:"]", color:gold, bold: true}]

scoreboard players set @s md_menu_ticks 600