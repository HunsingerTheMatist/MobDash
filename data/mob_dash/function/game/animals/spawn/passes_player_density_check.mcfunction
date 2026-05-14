# Decides whether the spawn-attempting player should run an attempt this cycle
# Runs as @s, at @s. Returns 1 (succeed) if the player should attempt a spawn,
#  fail otherwise
#
# Spawn probability is 100 / md_density_weight, where the weight reflects how much
#  spawn area this player shares with overlapping nearby players. A solo player has
#  weight 100 → 100% spawn (early-returned to skip the dice roll). Each nearby other
#  player adds a band-dependent weight (computed by 'add_density_weight'), so
#  overlapping clumps yield a high weight and a correspondingly low per-player prob
#  Across a cluster of N overlapping players the totals approximately to ~1× spawn
#  rate, matching vanilla's "scale with unique spawn-chunk area" behaviour

# Solo player (no neighbours contributed): weight is exactly 100 → 100% spawn
execute if score @s md_density_weight matches 100 run return 1

# Roll spawn probability = 100 / md_density_weight via `random value 0..999`
#  Threshold = 100000 / md_density_weight, so the random roll fires that fraction
#  of the [0, 999] range
execute store result score #spawn_roll md_state run random value 0..999

scoreboard players set #spawn_threshold md_state 100000
scoreboard players operation #spawn_threshold md_state /= @s md_density_weight
execute if score #spawn_roll md_state < #spawn_threshold md_state run return 1
return fail
