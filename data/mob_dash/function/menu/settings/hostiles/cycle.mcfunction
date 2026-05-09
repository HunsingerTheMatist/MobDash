# Switch between hostiles being off, on, and off at start

scoreboard players add $Hostiles md_setting 1
execute unless score $Hostiles md_setting matches 1..2 run scoreboard players set $Hostiles md_setting 0

function mob_dash:menu/settings/hostiles/update_text
execute as @a[tag=!md_tutorial] run function mob_dash:menu/push_menu
