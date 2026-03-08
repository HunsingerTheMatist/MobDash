tag @s add md_current2
execute as @p[tag=md_current] anchored eyes facing entity @n[tag=md_current2] eyes anchored feet positioned ^ ^ ^1 rotated as @s positioned ^ ^ ^-1 if entity @s[distance=..0.1] as @n[tag=md_current2] run say hi
tag @s remove md_current2