

execute if score $Bounties md_setting matches 0 run return 1

scoreboard players remove #bounty_countdown_minute md_state 1
execute if score #bounty_countdown_minute md_state matches 1.. run return 1

scoreboard players remove $BountyTick md_state 1
execute if score $BountyTick md_state matches ..0 run return run function mob_dash:game/bounty/add_new

scoreboard players set #bounty_countdown_minute md_state 1200

# Update the sidebar display
execute if entity @n[distance=..1,type=marker,tag=md_bounty,tag=md_selected] run return run function mob_dash:game/bounty/display_current
function mob_dash:game/bounty/display_none
