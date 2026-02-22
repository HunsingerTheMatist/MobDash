# Runs when the current mob has been killed (auto-generated file)

advancement revoke @s only mob_dash:kill_axolotl
tag @s add md_current
execute in mob_dash:mb_markers positioned 0 0 0 as @n[distance=0,type=marker,tag=md_selected,name="Axolotl"] run function mob_dash:game/award_kill
tag @s remove md_current