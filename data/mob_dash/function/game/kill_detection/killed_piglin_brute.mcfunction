# Runs when the current mob has been killed (auto-generated file)

advancement revoke @s only mob_dash:kill_piglin_brute
execute as @n[type=minecraft:marker,tag=md_selected,name="Piglin Brute"] run function mob_dash:game/award_kill