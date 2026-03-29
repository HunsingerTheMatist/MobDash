# Switch between operator-only mode being on and being off

function mob_dash:menu/op_auth
scoreboard players add $OpOnly md_setting 1
execute unless score $OpOnly md_setting matches 1 run scoreboard players set $OpOnly md_setting 0

function mob_dash:menu/settings/update_op_only_text
function mob_dash:menu/display_menu