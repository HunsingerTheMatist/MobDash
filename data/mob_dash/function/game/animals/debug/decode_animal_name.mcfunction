# Auto-generated. Decodes #picked_animal_id into Debug.AnimalName for the
#  spawn-print tellraw. ID -1 (set by 'try_spawn') or any unmatched value
#  falls through to the 'None' default, covering the 'no animal picked'
#  case where the summon never fired
# Caller: 'debug/spawn_print'

execute if score #picked_animal_id md_state matches 1 run return run data modify storage mob_dash:data Debug.AnimalName set value "Armadillo"
execute if score #picked_animal_id md_state matches 2 run return run data modify storage mob_dash:data Debug.AnimalName set value "Camel"
execute if score #picked_animal_id md_state matches 3 run return run data modify storage mob_dash:data Debug.AnimalName set value "Chicken"
execute if score #picked_animal_id md_state matches 4 run return run data modify storage mob_dash:data Debug.AnimalName set value "Cow"
execute if score #picked_animal_id md_state matches 5 run return run data modify storage mob_dash:data Debug.AnimalName set value "Donkey"
execute if score #picked_animal_id md_state matches 6 run return run data modify storage mob_dash:data Debug.AnimalName set value "Fox"
execute if score #picked_animal_id md_state matches 7 run return run data modify storage mob_dash:data Debug.AnimalName set value "Frog"
execute if score #picked_animal_id md_state matches 8 run return run data modify storage mob_dash:data Debug.AnimalName set value "Goat"
execute if score #picked_animal_id md_state matches 9 run return run data modify storage mob_dash:data Debug.AnimalName set value "Horse"
execute if score #picked_animal_id md_state matches 10 run return run data modify storage mob_dash:data Debug.AnimalName set value "Llama"
execute if score #picked_animal_id md_state matches 11 run return run data modify storage mob_dash:data Debug.AnimalName set value "Mooshroom"
execute if score #picked_animal_id md_state matches 12 run return run data modify storage mob_dash:data Debug.AnimalName set value "Panda"
execute if score #picked_animal_id md_state matches 13 run return run data modify storage mob_dash:data Debug.AnimalName set value "Parrot"
execute if score #picked_animal_id md_state matches 14 run return run data modify storage mob_dash:data Debug.AnimalName set value "Pig"
execute if score #picked_animal_id md_state matches 15 run return run data modify storage mob_dash:data Debug.AnimalName set value "Polar Bear"
execute if score #picked_animal_id md_state matches 16 run return run data modify storage mob_dash:data Debug.AnimalName set value "Rabbit"
execute if score #picked_animal_id md_state matches 17 run return run data modify storage mob_dash:data Debug.AnimalName set value "Sheep"
execute if score #picked_animal_id md_state matches 18 run return run data modify storage mob_dash:data Debug.AnimalName set value "Turtle"
execute if score #picked_animal_id md_state matches 19 run return run data modify storage mob_dash:data Debug.AnimalName set value "Wolf"

data modify storage mob_dash:data Debug.AnimalName set value "None"
