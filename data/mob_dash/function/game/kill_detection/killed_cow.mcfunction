# Runs when the current mob has been killed (auto-generated file)

advancement revoke @s only mob_dash:kill_cow
execute as @n[type=minecraft:marker,tag=md_selected,name="Cow"] run function mob_dash:game/award_kill