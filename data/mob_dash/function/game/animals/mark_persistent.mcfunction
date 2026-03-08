# Set the current animal as persistent

data modify entity @s PersistenceRequired set value true

# Remove its interaction id since it's already persistent
function mob_dash:game/animals/interaction/remove_id

# Give it the persistence tag and remove all other conflicting tags
tag @s add md_persistent
tag @s remove md_temp_persistent
tag @s remove md_has_or_is_passenger
tag @s remove md_despawn
tag @s remove md_despawn_batched
tag @s remove md_despawn_eligible

function mob_dash:game/animals/debug_glowing