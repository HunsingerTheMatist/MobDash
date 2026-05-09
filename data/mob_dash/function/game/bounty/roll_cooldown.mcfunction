# Set a random time between the min & the max countdowns until the next bounty

scoreboard players operation #temp md_state = $BountyMaxCountdown md_config
scoreboard players operation #temp md_state -= $BountyMinCountdown md_config
execute store result score $BountyTick md_state run random value 0..1000
scoreboard players operation $BountyTick md_state %= #temp md_state
scoreboard players operation $BountyTick md_state += $BountyMinCountdown md_config
scoreboard players set #bounty_countdown_minute md_state 1200
