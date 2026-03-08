# Get despawn & non-despawn chances for all distance ranges

scoreboard players operation #despawn_chance_0_63 md_state = $AnimalDespawnChance_0_63 md_state
scoreboard players operation #despawn_chance_0_63 md_state *= 100 md_const
scoreboard players operation #despawn_chance_0_63 md_state /= $AnimalTotalChance_0_63 md_state
scoreboard players set #nondespawn_chance_0_63 md_state 100
scoreboard players operation #nondespawn_chance_0_63 md_state -= #despawn_chance_0_63 md_state

scoreboard players operation #despawn_chance_64_127 md_state = $AnimalDespawnChance_64_127 md_state
scoreboard players operation #despawn_chance_64_127 md_state *= 100 md_const
scoreboard players operation #despawn_chance_64_127 md_state /= $AnimalTotalChance_64_127 md_state
scoreboard players set #nondespawn_chance_64_127 md_state 100
scoreboard players operation #nondespawn_chance_64_127 md_state -= #despawn_chance_64_127 md_state

scoreboard players operation #despawn_chance_128_plus md_state = $AnimalDespawnChance_128_plus md_state
scoreboard players operation #despawn_chance_128_plus md_state *= 100 md_const
scoreboard players operation #despawn_chance_128_plus md_state /= $AnimalTotalChance_128_plus md_state
scoreboard players set #nondespawn_chance_128_plus md_state 100
scoreboard players operation #nondespawn_chance_128_plus md_state -= #despawn_chance_128_plus md_state