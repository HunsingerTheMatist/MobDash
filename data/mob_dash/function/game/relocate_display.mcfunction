scoreboard players remove $BorderCooldown md_state 1

execute if score $BorderCooldown md_state matches -1 run title @a subtitle "3"
execute if score $BorderCooldown md_state matches -2 run title @a subtitle "2"
execute if score $BorderCooldown md_state matches -3 run title @a subtitle "1"

execute if score $BorderCooldown md_state matches -3.. run schedule function mob_dash:game/relocate_display 1s
execute if score $BorderCooldown md_state matches ..-4 as @p run function mob_dash:game/relocate_players
