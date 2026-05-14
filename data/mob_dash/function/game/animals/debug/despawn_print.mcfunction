# Print result of the most recent despawn roll. Builds the despawn /
#  non-despawn percentage text components from #despawn_chance, then prints
#  the matching tellraw based on #should_despawn. Caller: 'despawn/roll'
# The "Not Despawning" variant is commented out by default since it's noisy
#  — uncomment when investigating despawn rates
# Reads:
#   #despawn_chance md_state         per-mille [0..1000] despawn chance for this roll
#   #should_despawn md_state         1 = chosen for despawn, 0 = not chosen
#   #curr_despawn_batch md_state     current batch slot for the [Batch N] prefix
#   Debug.BracketLabel               "48-127" or "128+" set in 'despawn/roll'

# Build the despawn / non-despawn percent text components. #despawn_chance is
#  in per-mille (0..1000); split into whole percent (chance / 10) and
#  fractional tenths (chance % 10), then assemble an NBT list literal in
#  mob_dash:data storage. Tellraw renders via interpret:true. When frac == 0
#  the assembled component drops the decimal point and fractional score
#  (e.g. 30‰ → "3%")

# Complement on the same per-mille scale
scoreboard players set #nondespawn_chance md_state 1000
scoreboard players operation #nondespawn_chance md_state -= #despawn_chance md_state

# Whole percent + fractional tenths for both values
scoreboard players operation #despawn_chance_whole md_state = #despawn_chance md_state
scoreboard players operation #despawn_chance_whole md_state /= 10 md_const
scoreboard players operation #despawn_chance_frac md_state = #despawn_chance md_state
scoreboard players operation #despawn_chance_frac md_state %= 10 md_const

scoreboard players operation #nondespawn_chance_whole md_state = #nondespawn_chance md_state
scoreboard players operation #nondespawn_chance_whole md_state /= 10 md_const
scoreboard players operation #nondespawn_chance_frac md_state = #nondespawn_chance md_state
scoreboard players operation #nondespawn_chance_frac md_state %= 10 md_const

# Pick the no-decimal form when frac == 0 and the with-decimal form otherwise
execute if score #despawn_chance_frac md_state matches 0 run data modify storage mob_dash:data Debug.DespawnChancePercent set value [{score: {objective:md_state, name:"#despawn_chance_whole"}}, {text:"%"}]
execute unless score #despawn_chance_frac md_state matches 0 run data modify storage mob_dash:data Debug.DespawnChancePercent set value [{score: {objective:md_state, name:"#despawn_chance_whole"}}, {text:"."}, {score: {objective:md_state, name:"#despawn_chance_frac"}}, {text:"%"}]

execute if score #nondespawn_chance_frac md_state matches 0 run data modify storage mob_dash:data Debug.NondespawnChancePercent set value [{score: {objective:md_state, name:"#nondespawn_chance_whole"}}, {text:"%"}]
execute unless score #nondespawn_chance_frac md_state matches 0 run data modify storage mob_dash:data Debug.NondespawnChancePercent set value [{score: {objective:md_state, name:"#nondespawn_chance_whole"}}, {text:"."}, {score: {objective:md_state, name:"#nondespawn_chance_frac"}}, {text:"%"}]

# Debug message documenting that the selected mob was not chosen for despawn
#execute if score #should_despawn md_state matches 0 run \
#    tellraw @a ["",{text:"[Batch ", color:yellow, extra:[{score: {objective:md_state, name:"#curr_despawn_batch"}}, {text:"] "}]}, {text:"Not Despawning", color:green}, \
#    {text:" ("}, {storage:"mob_dash:data", nbt:Debug.BracketLabel}, {text: " "}, {storage:"mob_dash:data", nbt:Debug.NondespawnChancePercent, interpret:true, color:blue}, {text:") "}, {selector:"@s"}]

# Debug message documenting that the selected mob was chosen for despawn
execute if score #should_despawn md_state matches 1 run \
    tellraw @a ["",{text:"[Batch ", color:yellow, extra:[{score: {objective:md_state, name:"#curr_despawn_batch"}}, {text:"] "}]}, {text:"Despawning", color:red}, \
    {text:" ("}, {storage:"mob_dash:data", nbt:Debug.BracketLabel}, {text: " "}, {storage:"mob_dash:data", nbt:Debug.DespawnChancePercent, interpret:true, color:blue}, {text:") "}, {selector:"@s"}]
