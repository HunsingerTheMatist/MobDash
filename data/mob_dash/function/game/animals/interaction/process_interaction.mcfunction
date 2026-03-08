# Mark the animal found as persistent

execute unless score #debug_animal_handling md_state matches 0 run say Interacted
function mob_dash:game/animals/mark_persistent