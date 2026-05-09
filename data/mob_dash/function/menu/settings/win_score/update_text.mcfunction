execute if score $Win md_setting matches 0 run return run data modify storage mob_dash:data Settings.WinScore set value None
data modify storage mob_dash:data Settings.WinScore set value [{score: {objective:md_setting, name:"$Win"}}]
