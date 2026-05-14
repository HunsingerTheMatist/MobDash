# Rolls whether this animal despawns this cycle. Returns 1 on a successful roll
#  (despawn), fail otherwise. Caller: 'despawn/tick'
#
# Bracket: ±127 → low-rate roll. 128+ → high-rate roll

# Detect the bracket and pick the matching per-mille chance + display label
execute store success score #player_within_127 md_state positioned ~-127 -200 ~-127 if entity @p[predicate=mob_dash:spawn_driver,dx=253,dy=1000,dz=253]

execute if score #player_within_127 md_state matches 1 run scoreboard players operation #despawn_chance md_state = $AnimalDespawnChance_48_127 md_animal_config
execute if score #player_within_127 md_state matches 1 run data modify storage mob_dash:data Debug.BracketLabel set value "48-127"
execute if score #player_within_127 md_state matches 0 run scoreboard players operation #despawn_chance md_state = $AnimalDespawnChance_128_plus md_animal_config
execute if score #player_within_127 md_state matches 0 run data modify storage mob_dash:data Debug.BracketLabel set value "128+"

function mob_dash:game/animals/despawn/apply_cap_fullness_multiplier

# Roll a value in [0, 999] and compare against the per-mille chance
execute store result score #despawn_roll md_state run random value 0..999
execute store success score #should_despawn md_state if score #despawn_roll md_state < #despawn_chance md_state

execute unless score #debug_animal_handling md_animal_config matches 0 run function mob_dash:game/animals/debug/despawn_print

# Return whether or not the animal should despawn
return run execute if score #should_despawn md_state matches 1
