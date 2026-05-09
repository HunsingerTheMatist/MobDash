# Goes back to the menu after 30 seconds

scoreboard players add #end_wait md_state 1
execute unless score #end_wait md_state matches 1.. run return 1
scoreboard players set #end_wait md_state -19
scoreboard players remove #end_wait20 md_state 1
execute unless score #end_wait20 md_state matches 0..30 run scoreboard players set #end_wait20 md_state 30

execute if score #end_wait20 md_state matches 30 run bossbar add mob_dash:timer ""
execute if score #end_wait20 md_state matches 30 run bossbar set mob_dash:timer max 30

bossbar set mob_dash:timer players @a
execute store result bossbar mob_dash:timer value run scoreboard players get #end_wait20 md_state
bossbar set mob_dash:timer name [{score: {objective:md_state, name:"#end_wait20"}}]
execute if score #end_wait20 md_state matches 15.. run bossbar set mob_dash:timer color green
execute if score #end_wait20 md_state matches 7..14 run bossbar set mob_dash:timer color yellow
execute if score #end_wait20 md_state matches ..6 run bossbar set mob_dash:timer color red

execute if score #end_wait20 md_state matches 3 run title @a title "3"
execute if score #end_wait20 md_state matches 2 run title @a title "2"
execute if score #end_wait20 md_state matches 1 run title @a title "1"

execute if score #end_wait20 md_state matches 1.. run return 1

title @a clear
bossbar remove mob_dash:timer
execute as @a run function mob_dash:game/player/player_menu_setup
scoreboard players add $GameIndex md_state 10
function mob_dash:global/reset
execute at @n[distance=0..,type=marker,tag=md_game_spawn] positioned over motion_blocking_no_leaves run function mob_dash:menu/setup_spawn
