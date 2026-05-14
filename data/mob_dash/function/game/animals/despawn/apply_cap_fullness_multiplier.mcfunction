# Reduce #despawn_chance by a cap-fullness multiplier based on #min_player_cap
#  (the lowest md_animals_nearby across spawn_drivers within ±160 of the
#  executor):
#  - #min_player_cap <= #third_cap → apply $AnimalDespawnRateAtThirdCap
#  - #min_player_cap <= #half_cap  → apply $AnimalDespawnRateAtHalfCap
#  - above #half_cap               → no-op
# Rates are in percent (0-100), so each branch multiplies and divides by 100
# #min_player_cap is init to $AnimalPlayerCap so when no players are in range
#  the score stays above both thresholds and no reduction fires

scoreboard players operation #min_player_cap md_state = $AnimalPlayerCap md_animal_config
execute positioned ~-160 -200 ~-160 run scoreboard players operation \
    #min_player_cap md_state < @a[predicate=mob_dash:spawn_driver,dx=319,dy=1000,dz=319] md_animals_nearby

execute if score #min_player_cap md_state <= #third_cap md_state \
    run scoreboard players operation #despawn_chance md_state *= $AnimalDespawnRateAtThirdCap md_animal_config
execute if score #min_player_cap md_state <= #third_cap md_state \
    run return run scoreboard players operation #despawn_chance md_state /= 100 md_const

execute if score #min_player_cap md_state <= #half_cap md_state \
    run scoreboard players operation #despawn_chance md_state *= $AnimalDespawnRateAtHalfCap md_animal_config
execute if score #min_player_cap md_state <= #half_cap md_state \
    run scoreboard players operation #despawn_chance md_state /= 100 md_const
