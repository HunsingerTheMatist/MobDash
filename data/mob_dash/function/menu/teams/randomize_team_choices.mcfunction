# Picks @s TeamCount team colors (md_team values 1..8) to randomize into.
# Currently-occupied teams (those with >= 1 player) get priority; remaining
# slots are filled from random unoccupied teams. Each chosen marker gets the
# md_chosen tag.

# Reset prior state
tag @e[distance=..1,type=marker,tag=md_team] remove md_chosen

# Counter for remaining slots to fill
scoreboard players operation #picks_left md_state = @s TeamCount

# Pass 1: pick teams currently in use by any player (random order). The
# unless-entity guard prevents the same marker from being picked twice when
# multiple players share a team.
execute as @e[distance=..1,type=marker,tag=md_team,scores={md_team=1..8},sort=random] at @a if score @s md_team = @p md_team \ 
    unless entity @s[tag=md_chosen] if score #picks_left md_state matches 1.. run function mob_dash:menu/teams/randomize_choose_team

# Pass 2: fill remaining slots from un-chosen teams (random)
execute as @e[distance=..1,type=marker,tag=md_team,scores={md_team=1..8},tag=!md_chosen,sort=random] if score #picks_left md_state matches 1.. run function mob_dash:menu/teams/randomize_choose_team
