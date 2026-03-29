execute if score $Hostiles md_setting matches 0 run return run data modify storage mob_dash:data Settings.Hostiles set value Off
execute if score $Hostiles md_setting matches 1 run return run data modify storage mob_dash:data Settings.Hostiles set value On
data modify storage mob_dash:data Settings.Hostiles set value "Off at Start"