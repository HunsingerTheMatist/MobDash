# Tags the mob for despawn unless it is a passenger or has passengers

execute unless predicate mob_dash:has_or_is_passenger run tag @s add md_despawn