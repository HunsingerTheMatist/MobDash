
function mob_dash:game/player/reset_player

scoreboard players set @s md_team 9
team join gray @s
gamemode spectator @s