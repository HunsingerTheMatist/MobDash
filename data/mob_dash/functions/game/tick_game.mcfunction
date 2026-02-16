# runs every tick

execute unless entity @e[type=area_effect_cloud,tag=md_selected] run function mob_dash:game/new_target

scoreboard players add @e[type=area_effect_cloud,tag=md_selected] md_time 1
function mob_dash:game/calculate_target_score

function mob_dash:game/detect_kill
function mob_dash:game/update_scores

scoreboard players add $Tick md_state 1

execute unless score $Win md_state matches 0 run function mob_dash:game/check_win_score
execute unless score $Timeout md_state matches 0 run function mob_dash:game/check_time_limit

function mob_dash:game/display_action_bar

execute if score $EndTick md_state matches 1.. run function mob_dash:game/update_timer_bar

# Enables/disables triggers
execute if score $OpOnly md_state matches 0 run tag @a add md_op
scoreboard players enable @a[tag=md_op] HardReset
scoreboard players enable @a[tag=md_op] Reroll
execute as @a run trigger SetTeam add 0
execute as @a run trigger TimeLimit add 0
execute as @a run trigger WinScore add 0
execute if score $OpOnly md_state matches 0 run tag @a remove md_op

# Reroll the latest mob if requested
execute as @a[scores={Reroll=1..}] run function mob_dash:game/reroll_mob
scoreboard players set @a Reroll 0