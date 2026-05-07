# Stores the lowest base 3 bit, then bit-shifts down to the next base 3 bit
# Credit: https://github.com/picarrow/hit-match

scoreboard players operation #bit md_state = #temp md_state
scoreboard players operation #bit md_state %= 3 md_const
scoreboard players operation #temp md_state /= 3 md_const
