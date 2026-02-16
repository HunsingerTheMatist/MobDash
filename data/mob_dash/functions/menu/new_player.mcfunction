# Runs for every player on first join_team

execute if score $OpOnly md_state matches 1 run function mob_dash:menu/welcome

execute unless score @s md_team matches 1..9 run function mob_dash:menu/randomize_team
execute unless score @s md_team matches 1..9 run function mob_dash:menu/join_team

tag @s add md_assigned
