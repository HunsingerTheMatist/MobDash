# Macro: overwrites Debug.AnimalSpawn.click_event.command with the actual /tp
#  command for the most recent spawn attempt. The rest of Debug.AnimalSpawn (text,
#  extra refs to Debug.MacroArgs.x/y/z, hover_event, etc.) is initialized once on
#  load by mob_dash:load/store_text. Caller 'spawn_print' passes integer x, y, z
#  via storage; this macro substitutes them into the click_event command

$data modify storage mob_dash:data Debug.AnimalSpawn.click_event.command set value "/tp @s $(x) $(y) $(z)"
