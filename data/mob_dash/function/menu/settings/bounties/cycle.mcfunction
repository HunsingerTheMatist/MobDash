# Switch between bounties being enabled and disabled

scoreboard players add $Bounties md_setting 1
execute unless score $Bounties md_setting matches 1 run scoreboard players set $Bounties md_setting 0

function mob_dash:menu/settings/bounties/update_text
execute as @a[tag=!md_tutorial] run function mob_dash:menu/push_menu
