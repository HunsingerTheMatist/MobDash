# If an animal has PersistenceRequired on and hasn't been processed yet, assume it generated with a structure & tag it as persistent
# When calling this function the entities should be filtered by `tag=!md_structure_persistence_checked`

execute if entity @s[tag=!md_persistent,nbt={PersistenceRequired:true}] run function mob_dash:game/animals/mark_persistent
tag @s add md_structure_persistence_checked
