
function mob_dash:game/player/reset_player

effect give @s instant_health 1 10 true
effect give @s saturation 1 10 true
effect give @s resistance 1 10 true

gamemode survival @s[team=!gray]
gamemode spectator @s[team=gray]

# Reset all advancements except for entering the nether
gamerule show_advancement_messages false
advancement revoke @s everything
advancement grant @s only story/enter_the_nether
gamerule show_advancement_messages true