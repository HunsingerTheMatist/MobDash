# Assigns ids to any animals that don't have them; also processes running out of ids
# Credit: https://github.com/picarrow/hit-match

# Resets all ids if the amount of animals without ids is greater than the number of ids left
execute store result score #animals_without_ids md_state if entity @e[type=#mob_dash:non_persistent_animals,tag=!md_persistent,predicate=!mob_dash:has_id]
execute if score #animals_without_ids md_state matches 0 run return 1
scoreboard players set #ids_left md_state 19683
scoreboard players operation #ids_left md_state -= #next_id md_state
execute if score #animals_without_ids md_state > #ids_left md_state run function mob_dash:game/animals/interaction/reset_all_ids

# Assigns ids to any non-persistent animals that don't have them
execute as @e[type=#mob_dash:non_persistent_animals,tag=!md_persistent,predicate=!mob_dash:has_id] run function mob_dash:game/animals/interaction/assign_animal_id
