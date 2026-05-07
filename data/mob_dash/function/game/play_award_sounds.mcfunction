# Play success sounds to all players part of the team of the current player + specs, and fail sounds to all other players

execute as @a[scores={md_team=1..8}] if score @s md_team = @p[tag=md_current] md_team at @s run playsound minecraft:block.note_block.bell master @s ~ ~ ~ 1 0.6
execute as @a[scores={md_team=9}] at @s run playsound minecraft:block.note_block.bell master @s ~ ~ ~ 1 0.6
execute as @a[scores={md_team=1..8}] unless score @s md_team = @p[tag=md_current] md_team at @s run playsound minecraft:block.note_block.didgeridoo master @s ~ ~ ~ 1 0.5
