# Sets up the game marker entities in the md_markers dimension

# If not in the md_markers dimension call this function again from that dimension (this is because schedule resets the dimension & position)
execute unless dimension mob_dash:md_markers in mob_dash:md_markers positioned 0 0 0 run return run function mob_dash:load/setup_markers

# If the current chunk isn't loaded schedule this function to try again in 10 ticks
execute unless loaded ~ ~ ~ run forceload add ~ ~
execute unless loaded ~ ~ ~ run return run schedule function mob_dash:load/setup_markers 10

# If necessary, create the team, target, and bounty markers
execute unless entity @n[distance=..1,type=marker,tag=md_team] run function mob_dash:load/create_teams
execute unless entity @n[distance=..1,type=marker,tag=md_target] run function mob_dash:load/create_targets
execute unless entity @n[distance=..1,type=marker,tag=md_bounty] run function mob_dash:load/create_bounties
