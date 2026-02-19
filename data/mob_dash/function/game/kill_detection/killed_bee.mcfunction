# Runs when the current mob has been killed (auto-generated file)

advancement revoke @s only mob_dash:kill_bee
execute as @n[type=minecraft:marker,tag=md_selected,name="Bee"] run function mob_dash:game/award_kill