# Award score reward to the team of @s

tag @s add md_killed

execute if score $GameState md_state matches 3 as @e[distance=..1,type=marker,tag=md_team] if score @s md_team = @p[tag=md_current] md_team run function mob_dash:game/increase_score
execute if score $GameState md_state matches 3 run function mob_dash:game/play_award_sounds

function mob_dash:game/target/remove_target