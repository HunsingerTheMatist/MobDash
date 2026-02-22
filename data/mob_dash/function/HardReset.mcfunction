# Hard reset the minigame

kill @e[type=minecraft:marker]
scoreboard objectives remove md_state
scoreboard objectives remove md_menu_ticks

function mob_dash:load