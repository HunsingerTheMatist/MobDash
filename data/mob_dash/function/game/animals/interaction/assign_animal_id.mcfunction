# Assigns a new unique id to the current animal
# Credit: https://github.com/picarrow/hit-match

scoreboard players operation @s md_id = #next_id md_state
scoreboard players add #next_id md_state 1

# Write each base 3 bit into the various score values
scoreboard players operation #temp md_state = @s md_id

function mob_dash:game/animals/interaction/next_bit
scoreboard players operation @s md_id_0 = #bit md_state

function mob_dash:game/animals/interaction/next_bit
scoreboard players operation @s md_id_1 = #bit md_state

function mob_dash:game/animals/interaction/next_bit
scoreboard players operation @s md_id_2 = #bit md_state

function mob_dash:game/animals/interaction/next_bit
scoreboard players operation @s md_id_3 = #bit md_state

function mob_dash:game/animals/interaction/next_bit
scoreboard players operation @s md_id_4 = #bit md_state

function mob_dash:game/animals/interaction/next_bit
scoreboard players operation @s md_id_5 = #bit md_state

function mob_dash:game/animals/interaction/next_bit
scoreboard players operation @s md_id_6 = #bit md_state

function mob_dash:game/animals/interaction/next_bit
scoreboard players operation @s md_id_7 = #bit md_state

function mob_dash:game/animals/interaction/next_bit
scoreboard players operation @s md_id_8 = #bit md_state