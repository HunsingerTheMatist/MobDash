
scoreboard players operation $GameIndex md_state %= 10 md_const
scoreboard players operation $GameIndex md_state += $GameState md_state
execute as @a[scores={md_game_idx=0..}] run scoreboard players operation @s md_game_idx = $GameIndex md_state
