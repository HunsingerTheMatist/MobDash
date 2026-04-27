# Runs when the current bounty has been killed (auto-generated file)

advancement revoke @s only mob_dash:kill_zombie_nautilus_jockey
tag @s add md_current
execute in mob_dash:md_markers positioned 0 0 0 as @n[distance=..1,type=marker,tag=md_bounty,tag=md_selected,tag=md_zombie_nautilus_jockey] run function mob_dash:game/bounty/award_kill
tag @s remove md_current