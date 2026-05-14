# Decrement the per-player cache TTL; if it hits 0, fire 'refresh_player_caches'
#  to recompute @s md_density_weight and @s md_animals_nearby. Always returns 1
# Runs as @s, at @s
# An uninitialized md_cache_ttl reads as 0 -> decrement to -1 -> matches ..0
#  -> first call triggers an immediate refresh for new players

scoreboard players remove @s md_cache_ttl 1
execute if score @s md_cache_ttl matches ..0 run function mob_dash:game/animals/spawn/refresh_player_caches
return 1
