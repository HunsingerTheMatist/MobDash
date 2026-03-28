# Clean up bounty stats

scoreboard players reset @s md_score

tag @s remove md_selected
tag @s remove md_killed

# Update sidebar display
function mob_dash:game/bounty/display_no_bounty