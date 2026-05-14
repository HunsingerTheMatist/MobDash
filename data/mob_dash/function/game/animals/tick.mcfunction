# Runs every tick when the game is running
#
# Cycle layout (20 ticks long, ticks 1..20):
#  - Tick 1, 3, ..., 19 → dispatch one despawn batch (10 batches per cycle)
#  - Tick 2, 4, ..., 18 → dispatch a spawn-fire pass for one md_batch_id slot
#     (#curr_spawn_batch cycles 0/1/2 → 3 spawn fires per slot per cycle)
#  - Tick 10        → 'assign_missing_ids' (scans for new animals without IDs)
#  - Tick 20        → end-of-cycle work: 'prepare_cycle' handles persistence
#                     marking and rebatch

# Process whether the $UseAnimalDespawning toggle is on or not
execute if score $UseAnimalDespawning md_animal_config matches 0 run return run function mob_dash:game/animals/disable
execute if score #prev_use_animal_despawning md_state matches 0 run function mob_dash:game/animals/enable

# Advance the 20-tick scheduler. #animal_tick is the cycle position (1..20),
#  #animal_tick_mod2 alternates 1/0 to split despawn vs spawn ticks. Both
#  increment unconditionally; mod2 wraps to 0 at 2
scoreboard players add #animal_tick md_state 1
scoreboard players add #animal_tick_mod2 md_state 1
execute if score #animal_tick_mod2 md_state matches 2.. run scoreboard players set #animal_tick_mod2 md_state 0

# Despawn fires on every odd tick (mod2 == 1) → 10 batches per cycle (ticks 1,3,...,19)
execute if score #animal_tick_mod2 md_state matches 1 run function mob_dash:game/animals/despawn/tick

# Spawn fires on every even tick (mod2 == 0) except tick 20 (heavy-work-only tick)
#  → 9 spawn-fire ticks (2,4,...,18). With mod3 advancing every tick, those land on
#  offsets 2,1,0,2,1,0,2,1,0 — clean 3/3/3 across the three player offsets
execute if score #animal_tick_mod2 md_state matches 0 unless score #animal_tick md_state matches 20 run function mob_dash:game/animals/spawn/tick

# Assign IDs to newly-spawned animals on tick 10 (once per cycle). New animals
#  get their ID within up to 1 second of spawning, which is invisible to
#  interaction logic since the player can't interact with a mob in its first tick
execute if score #animal_tick md_state matches 10 run function mob_dash:game/animals/interaction/assign_missing_ids

# Within-cycle exit. Heavy work only runs at end of cycle (tick 20)
execute if score #animal_tick md_state matches ..19 run return 1

# End of cycle: reset the tick counters, then hand off the heavy work to
#  'prepare_cycle' (persistence checks, rebatch)
scoreboard players set #animal_tick md_state 0
scoreboard players set #animal_tick_mod2 md_state 0
function mob_dash:game/animals/prepare_cycle
