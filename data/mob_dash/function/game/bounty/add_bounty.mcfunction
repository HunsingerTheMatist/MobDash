# Select a new bounty and display

# Mark all bounties as eligible
tag @e[distance=..1,type=marker,tag=md_eligible] remove md_eligible
tag @e[distance=..1,type=marker,tag=md_bounty,tag=!md_prev_selected] add md_eligible

# Remove hostile bounties if hostiles setting is off
execute if score $Hostiles md_setting matches 0 run tag @e[distance=..1,type=marker,tag=md_eligible,tag=md_hostile] remove md_eligible

# Remove nether bounties if nether setting is off
execute if score $Nether md_setting matches 0 run tag @e[distance=..1,type=marker,tag=md_eligible,tag=md_nether] remove md_eligible

# Randomly select a bounty from the list of eligible bounties
function mob_dash:game/target/choose_from_eligible

tag @e[distance=..1,type=marker,tag=md_bounty,tag=md_selected] remove md_selected
tag @e[distance=..1,type=marker,tag=md_bounty,tag=md_prev_selected] remove md_prev_selected
execute as @n[distance=..1,type=marker,tag=md_bounty,tag=md_selected_new] run function mob_dash:game/bounty/setup_new_bounty

# Delay target ticking by up to 100 ticks if necessary to prevent title overlap
scoreboard players set #new_target_delay md_state 100

# Set a random cooldown until the next bounty
function mob_dash:game/bounty/roll_bounty_cooldown

# Play sounds to notify players of a new bounty
execute as @a at @s run playsound minecraft:block.vault.open_shutter master @s ~ ~ ~ 0.5 1.25
execute as @a at @s run playsound minecraft:block.vault.open_shutter master @s ~ ~ ~ 0.5 1.5
execute as @a at @s run playsound minecraft:block.vault.open_shutter master @s ~ ~ ~ 0.5 2

# Update the sidebar display
function mob_dash:game/bounty/display_bounty
