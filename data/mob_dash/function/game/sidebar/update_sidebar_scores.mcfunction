# Update display scoreboard for teams

execute as @n[distance=..1,type=marker,tag=md_team,scores={md_team=1,md_team_count=1..}] run function mob_dash:game/sidebar/update_team1
execute as @n[distance=..1,type=marker,tag=md_team,scores={md_team=2,md_team_count=1..}] run function mob_dash:game/sidebar/update_team2
execute as @n[distance=..1,type=marker,tag=md_team,scores={md_team=3,md_team_count=1..}] run function mob_dash:game/sidebar/update_team3
execute as @n[distance=..1,type=marker,tag=md_team,scores={md_team=4,md_team_count=1..}] run function mob_dash:game/sidebar/update_team4
execute as @n[distance=..1,type=marker,tag=md_team,scores={md_team=5,md_team_count=1..}] run function mob_dash:game/sidebar/update_team5
execute as @n[distance=..1,type=marker,tag=md_team,scores={md_team=6,md_team_count=1..}] run function mob_dash:game/sidebar/update_team6
execute as @n[distance=..1,type=marker,tag=md_team,scores={md_team=7,md_team_count=1..}] run function mob_dash:game/sidebar/update_team7
execute as @n[distance=..1,type=marker,tag=md_team,scores={md_team=8,md_team_count=1..}] run function mob_dash:game/sidebar/update_team8
