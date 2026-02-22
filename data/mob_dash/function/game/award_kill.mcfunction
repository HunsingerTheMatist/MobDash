# Award score reward to the team of @s

tag @s add md_killed
execute as @e[distance=0,type=marker,tag=md_team] if score @s md_team = @p[tag=md_current] md_team run function mob_dash:game/increase_score
execute as @a[scores={md_team=1..8}] if score @s md_team = @p[tag=md_current] md_team at @s run playsound minecraft:block.note_block.bell master @s ~ ~ ~ 1 0.6
execute as @a[scores={md_team=1..8}] unless score @s md_team = @p[tag=md_current] md_team at @s run playsound minecraft:block.note_block.didgeridoo master @s ~ ~ ~ 1 0.5

function mob_dash:game/target/remove_target