
scoreboard players operation $GameIndex md_state %= 10 md_const
scoreboard players operation $GameIndex md_state += $GameState md_state
scoreboard players operation @a md_game_idx = $GameIndex md_state