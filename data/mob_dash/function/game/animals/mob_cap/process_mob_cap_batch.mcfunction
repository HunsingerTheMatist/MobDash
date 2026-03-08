# Process the mob caps of all players in the current batch

scoreboard players add #curr_mob_cap_batch md_state 1

execute as @a[gamemode=!spectator] if score @s md_batch_idx = #curr_mob_cap_batch md_state at @s run function mob_dash:game/animals/mob_cap/process_player