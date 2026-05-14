# On datapack load

# Scoreboards for animal-cap and despawn handling
scoreboard objectives add md_animal_config dummy "Mob Dash Animal Configs"
scoreboard objectives add md_batch_id dummy
scoreboard objectives add md_animals_nearby dummy
scoreboard objectives add md_despawn_timer dummy

# Scoreboards for animal spawning
scoreboard objectives add md_animal_spawns dummy
scoreboard objectives add animal_weight dummy

# Per-player spawn-pipeline cache
scoreboard objectives add md_density_weight dummy
scoreboard objectives add md_cache_ttl dummy

# Scoreboards for the animal-interaction system
scoreboard objectives add md_id dummy
scoreboard objectives add md_id_0 dummy
scoreboard objectives add md_id_1 dummy
scoreboard objectives add md_id_2 dummy
scoreboard objectives add md_id_3 dummy
scoreboard objectives add md_id_4 dummy
scoreboard objectives add md_id_5 dummy
scoreboard objectives add md_id_6 dummy
scoreboard objectives add md_id_7 dummy
scoreboard objectives add md_id_8 dummy

# Set default configs
execute unless score $UseAnimalDespawning md_animal_config matches 0..1 run scoreboard players set $UseAnimalDespawning md_animal_config 1

# Per-player persistent-animal cap
execute unless score $AnimalPlayerCap md_animal_config matches 1.. run scoreboard players set $AnimalPlayerCap md_animal_config 50

# Cap-fullness multipliers applied to the despawn chance when any nearby player
#  has headroom in their cap, in percent (0-100). At half-cap, despawn fires at
#  65% of the base bracket rate; at third-cap, 35%. Scales both brackets
#  proportionally
execute unless score $AnimalDespawnRateAtHalfCap md_animal_config matches 0..100 run scoreboard players set $AnimalDespawnRateAtHalfCap md_animal_config 65
execute unless score $AnimalDespawnRateAtThirdCap md_animal_config matches 0..100 run scoreboard players set $AnimalDespawnRateAtThirdCap md_animal_config 35

# Per-second despawn chance per bracket, in per-mille (0-1000)
#  48-127: 20/1000 = 2% ≈ 50 sec lifetime
#  128+: 100/1000 = 10% ≈ 10 sec lifetime
#  The 30-sec md_despawn_timer grace in 'not_eligible' handles the
#  ±47 close range and is layered on top of these
execute unless score $AnimalDespawnChance_48_127 md_animal_config matches 0..1000 run scoreboard players set $AnimalDespawnChance_48_127 md_animal_config 20
execute unless score $AnimalDespawnChance_128_plus md_animal_config matches 0..1000 run scoreboard players set $AnimalDespawnChance_128_plus md_animal_config 100

# Per-attempt spawn-rate multiplier, in percent (0-100). At 100 (default),
#  every spawn attempt proceeds; at 50, half are rolled away; at 0, none fire
#  Skipped entirely when 100
execute unless score $AnimalSpawnRateMultiplier md_animal_config matches 0..100 run scoreboard players set $AnimalSpawnRateMultiplier md_animal_config 100

# Per-spawn chance an eligible animal spawns as a baby, in per-mille (0..1000)
#  Default 50 → 5%. Same scale as the despawn chances so the rolls share a
#  uniform [0, 999] random range across both pipelines
execute unless score $BabySpawnChance md_animal_config matches 0..1000 run scoreboard players set $BabySpawnChance md_animal_config 50

# Debug modes
scoreboard players set #debug_animal_handling md_animal_config 0
scoreboard players set #debug_animal_spawning md_animal_config 0

# Spawn-attempt counters (cumulative since last 'hard_reset')
scoreboard players add #spawn_successes md_state 0
scoreboard players add #spawn_attempts md_state 0

# Set interaction logic id
execute unless score #next_id md_state matches 1.. run scoreboard players set #next_id md_state 1

# Auto-generated per-(canonical, animal) weight setters
function mob_dash:game/animals/spawn/initialize_weights

# Compute per-canonical totals from the per-(canonical, animal) weights
function mob_dash:game/animals/spawn/refresh_weight_sums
