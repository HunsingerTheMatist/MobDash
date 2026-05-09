execute if score $Timeout md_setting matches 0 run return run data modify storage mob_dash:data Settings.TimeLimit set value None
data modify storage mob_dash:data Settings.TimeLimit set value [{score: {objective:md_setting, name:"$Timeout"}}, {text:" min"}]
