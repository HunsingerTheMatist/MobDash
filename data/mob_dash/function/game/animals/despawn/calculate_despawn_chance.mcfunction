execute if score @p md_player_cap <= #third_cap md_state \
    run return run scoreboard players operation #despawn_chance md_state -= $AnimalDespawnChanceReduction_ThirdCap md_animal_config

execute if score @p md_player_cap <= #half_cap md_state \
    run return run scoreboard players operation #despawn_chance md_state -= $AnimalDespawnChanceReduction_HalfCap md_animal_config