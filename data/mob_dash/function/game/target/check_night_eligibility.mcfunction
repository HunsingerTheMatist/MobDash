# Make night mobs more frequent towards the night, stored in $NightValue
# Piece-wise function shown below: ($NightValue as 'y', $DayTick as 'x')
# y = 2500 {0 <= x <= 8000 }
# y = x - 5500 {8000 <= x <= 13000}
# y = 7500 {13000 <= x <= 19000}
# y = 26500 - x {19000 <= x <= 24000}
execute store result score $DayTick md_state run time of overworld query day
scoreboard players operation $NightValue md_state = $DayTick md_state
execute if score $DayTick md_state matches ..8000 run scoreboard players set $NightValue md_state 2500
execute if score $DayTick md_state matches 8000..13000 run scoreboard players remove $NightValue md_state 5500
execute if score $DayTick md_state matches 13000..19000 run scoreboard players set $NightValue md_state 7500
execute if score $DayTick md_state matches 19000.. run scoreboard players operation $NightValue md_state *= -1 md_const
execute if score $DayTick md_state matches 19000.. run scoreboard players add $NightValue md_state 26500

# Remove night mobs if random value is above $NightValue
execute store result score $Random md_state run random value 0..24000
execute if score $Random md_state > $NightValue md_state run tag @e[distance=..1,type=marker,tag=md_eligible,tag=md_night] remove md_eligible