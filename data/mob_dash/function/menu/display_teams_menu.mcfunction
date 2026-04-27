# Show team switching menu to @s

execute unless dimension mob_dash:md_markers in mob_dash:md_markers positioned 0 0 0 run return run function mob_dash:menu/display_teams_menu

tellraw @s ""
tellraw @s [{text:"- "}, {text:"[", color:gold, bold: true}, {text:"Join ", color:white, click_event: {action:run_command, command:"trigger SetTeam set 1"}, extra: [{selector:"@n[distance=..1,type=marker,tag=md_team,scores={md_team=1}]"}]}, {text:"]", color:gold, bold: true}]
tellraw @s [{text:"- "}, {text:"[", color:gold, bold: true}, {text:"Join ", color:white, click_event: {action:run_command, command:"trigger SetTeam set 2"}, extra: [{selector:"@n[distance=..1,type=marker,tag=md_team,scores={md_team=2}]"}]}, {text:"]", color:gold, bold: true}]
tellraw @s [{text:"- "}, {text:"[", color:gold, bold: true}, {text:"Join ", color:white, click_event: {action:run_command, command:"trigger SetTeam set 3"}, extra: [{selector:"@n[distance=..1,type=marker,tag=md_team,scores={md_team=3}]"}]}, {text:"]", color:gold, bold: true}]
tellraw @s [{text:"- "}, {text:"[", color:gold, bold: true}, {text:"Join ", color:white, click_event: {action:run_command, command:"trigger SetTeam set 4"}, extra: [{selector:"@n[distance=..1,type=marker,tag=md_team,scores={md_team=4}]"}]}, {text:"]", color:gold, bold: true}]
tellraw @s [{text:"- "}, {text:"[", color:gold, bold: true}, {text:"Join ", color:white, click_event: {action:run_command, command:"trigger SetTeam set 5"}, extra: [{selector:"@n[distance=..1,type=marker,tag=md_team,scores={md_team=5}]"}]}, {text:"]", color:gold, bold: true}]
tellraw @s [{text:"- "}, {text:"[", color:gold, bold: true}, {text:"Join ", color:white, click_event: {action:run_command, command:"trigger SetTeam set 6"}, extra: [{selector:"@n[distance=..1,type=marker,tag=md_team,scores={md_team=6}]"}]}, {text:"]", color:gold, bold: true}]
tellraw @s [{text:"- "}, {text:"[", color:gold, bold: true}, {text:"Join ", color:white, click_event: {action:run_command, command:"trigger SetTeam set 7"}, extra: [{selector:"@n[distance=..1,type=marker,tag=md_team,scores={md_team=7}]"}]}, {text:"]", color:gold, bold: true}]
tellraw @s [{text:"- "}, {text:"[", color:gold, bold: true}, {text:"Join ", color:white, click_event: {action:run_command, command:"trigger SetTeam set 8"}, extra: [{selector:"@n[distance=..1,type=marker,tag=md_team,scores={md_team=8}]"}]}, {text:"]", color:gold, bold: true}]
tellraw @s [{text:"- "}, {text:"[", color:gold, bold: true}, {text:"Join ", color:white, click_event: {action:run_command, command:"trigger SetTeam set 9"}, extra: [{selector:"@n[distance=..1,type=marker,tag=md_team,scores={md_team=9}]"}]}, {text:"]", color:gold, bold: true}, {text:" (Spec Team)"}]

scoreboard players set @s md_menu_ticks 2400
