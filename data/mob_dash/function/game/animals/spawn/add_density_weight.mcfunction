# Adds a band-dependent weight to #density_weight based on how close the spawn-
#  attempting player (tagged md_current) is to this iterating other player (@s)
# Runs as @s, at @s
#
# Bands are box-distance (L∞), each cutoff being the area-equivalent of a euclidean
#  reference: 32 → ±28, 64 → ±57, 96 → ±85, 128 → ±113, 160 → ±144 (the outer
#  pruning radius). The 113-144 fall-through covers "still in cap range but outside
#  spawn-disc overlap" — vanilla's spawn disc is 128 euclidean = 113 box, so any
#  player in that outer ring contributes little to actual shared spawn area
# Weights approximate the box-overlap fraction of two ±144 spawn boxes at the band's
#  centre, fed through W = 100·O / (2-O) so per-player spawn probability tracks the
#  "fair share of unique area" semantic across cluster sizes
#
# Closest band first; checks fall through to the outermost band at the bottom

execute positioned ~-028 -200 ~-028 if entity @p[tag=md_current,dx=055,dy=1000,dz=055] run return run scoreboard players add #density_weight md_state 90
execute positioned ~-057 -200 ~-057 if entity @p[tag=md_current,dx=113,dy=1000,dz=113] run return run scoreboard players add #density_weight md_state 75
execute positioned ~-085 -200 ~-085 if entity @p[tag=md_current,dx=169,dy=1000,dz=169] run return run scoreboard players add #density_weight md_state 60
execute positioned ~-113 -200 ~-113 if entity @p[tag=md_current,dx=225,dy=1000,dz=225] run return run scoreboard players add #density_weight md_state 45
scoreboard players add #density_weight md_state 30
