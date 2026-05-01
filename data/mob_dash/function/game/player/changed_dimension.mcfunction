# Runs whenever a player changes dimensions

advancement revoke @s only mob_dash:changed_dimension

# Hide the locator bar from the player if they are in the nether
# add_multiplied_total -1 -> total *= (1 + -1) = 0, regardless of base.
execute if dimension the_nether run attribute @s waypoint_receive_range modifier add mob_dash:hide_in_nether -1 add_multiplied_total

# Otherwise, drop the modifier so the default range applies
execute unless dimension the_nether run attribute @s waypoint_receive_range modifier remove mob_dash:hide_in_nether