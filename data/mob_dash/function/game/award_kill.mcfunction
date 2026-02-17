# Note: This runs as the marker and at the position of the player who killed the mob
tag @s add md_killed

# Award score reward to the team of @p
execute as @e[type=marker,tag=md_team] if score @s md_team = @p md_team run function mob_dash:game/increase_score
execute as @a[scores={md_team=1..8}] if score @s md_team = @p md_team at @s run playsound minecraft:block.note_block.bell master @s ~ ~ ~ 1 0.6
execute as @a[scores={md_team=1..8}] unless score @s md_team = @p md_team at @s run playsound minecraft:block.note_block.didgeridoo master @s ~ ~ ~ 1 0.5

function mob_dash:game/remove_target