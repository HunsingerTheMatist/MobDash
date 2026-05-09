# Reset back to menu state

scoreboard players set $GameState md_state 0
function mob_dash:global/update_game_index

scoreboard players reset * md_menu_ticks
scoreboard players reset * md_ticks
scoreboard players reset * md_score

worldborder set 50000

bossbar remove mob_dash:timer
