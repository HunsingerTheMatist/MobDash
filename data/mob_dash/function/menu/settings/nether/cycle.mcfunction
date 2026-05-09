# Switch between nether mobs being enabled and disabled

scoreboard players add $Nether md_setting 1
execute unless score $Nether md_setting matches 1 run scoreboard players set $Nether md_setting 0

function mob_dash:menu/settings/nether/update_text
execute as @a[tag=!md_tutorial] run function mob_dash:menu/push_menu
