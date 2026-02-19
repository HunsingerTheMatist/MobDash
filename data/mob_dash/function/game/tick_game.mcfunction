# Runs every tick when the game is running

# Check if the game has ended on time limit
scoreboard players add $GameTick md_state 1
execute if score $EndTick md_state matches 1.. if score $GameTick md_state >= $EndTick md_state run function mob_dash:game/end_game

# Update the bossbar timer
execute if score $EndTick md_state matches 1.. run function mob_dash:game/update_timer_bar

# Process targets
scoreboard players remove $TargetTick md_state 1
execute if score $TargetTick md_state matches ..0 run function mob_dash:game/target/process_targets

# Process action bar
scoreboard players remove $ActionBarTick md_state 1
execute if score $ActionBarTick md_state matches ..0 run function mob_dash:game/display_action_bar

# Enables/disables triggers
execute if score $OpOnly md_state matches 0 run tag @a add md_op
scoreboard players enable @a[tag=md_op] HardReset
scoreboard players enable @a[tag=md_op] Reroll
execute as @a run trigger SetTeam add 0
execute as @a run trigger TimeLimit add 0
execute as @a run trigger WinScore add 0
execute if score $OpOnly md_state matches 0 run tag @a remove md_op

# Reroll the latest mob if requested
execute as @a[scores={Reroll=1..}] run function mob_dash:game/target/reroll_mob
scoreboard players set @a Reroll 0