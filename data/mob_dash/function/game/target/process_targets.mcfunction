scoreboard players operation $TargetTick md_state = $ScorePeriod md_state

function mob_dash:game/target/increment_target_scores

execute unless entity @n[distance=0,type=marker,tag=md_selected] run function mob_dash:game/target/add_target