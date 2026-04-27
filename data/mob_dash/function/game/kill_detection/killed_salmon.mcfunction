# Runs when the current mob has been killed (auto-generated file)

advancement revoke @s only mob_dash:kill_salmon
tag @s add md_current
execute in mob_dash:md_markers positioned 0 0 0 as @n[distance=..1,type=marker,tag=md_target,tag=md_selected,tag=md_salmon] run function mob_dash:game/award_kill
tag @s remove md_current