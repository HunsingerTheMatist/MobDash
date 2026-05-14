# Auto-generated. Recomputes #<canonical>_total animal_weight by summing the
#  per-animal weights for that canonical. Biomes with identical animal spawn
#  lists share a canonical's total via the picker dispatch
# Run on load and after any change to per-animal weights

scoreboard players set #badlands_group_total animal_weight 0
scoreboard players operation #badlands_group_total animal_weight += #badlands_group_armadillo animal_weight
scoreboard players operation #badlands_group_total animal_weight += #badlands_group_chicken animal_weight
scoreboard players operation #badlands_group_total animal_weight += #badlands_group_cow animal_weight
scoreboard players operation #badlands_group_total animal_weight += #badlands_group_pig animal_weight
scoreboard players operation #badlands_group_total animal_weight += #badlands_group_sheep animal_weight

scoreboard players set #bamboo_jungle_total animal_weight 0
scoreboard players operation #bamboo_jungle_total animal_weight += #bamboo_jungle_chicken animal_weight
scoreboard players operation #bamboo_jungle_total animal_weight += #bamboo_jungle_cow animal_weight
scoreboard players operation #bamboo_jungle_total animal_weight += #bamboo_jungle_panda animal_weight
scoreboard players operation #bamboo_jungle_total animal_weight += #bamboo_jungle_parrot animal_weight
scoreboard players operation #bamboo_jungle_total animal_weight += #bamboo_jungle_pig animal_weight
scoreboard players operation #bamboo_jungle_total animal_weight += #bamboo_jungle_sheep animal_weight

scoreboard players set #beach_total animal_weight 0
scoreboard players operation #beach_total animal_weight += #beach_turtle animal_weight

scoreboard players set #cherry_grove_total animal_weight 0
scoreboard players operation #cherry_grove_total animal_weight += #cherry_grove_pig animal_weight
scoreboard players operation #cherry_grove_total animal_weight += #cherry_grove_rabbit animal_weight
scoreboard players operation #cherry_grove_total animal_weight += #cherry_grove_sheep animal_weight

scoreboard players set #desert_total animal_weight 0
scoreboard players operation #desert_total animal_weight += #desert_camel animal_weight
scoreboard players operation #desert_total animal_weight += #desert_rabbit animal_weight

scoreboard players set #flower_forest_total animal_weight 0
scoreboard players operation #flower_forest_total animal_weight += #flower_forest_chicken animal_weight
scoreboard players operation #flower_forest_total animal_weight += #flower_forest_cow animal_weight
scoreboard players operation #flower_forest_total animal_weight += #flower_forest_pig animal_weight
scoreboard players operation #flower_forest_total animal_weight += #flower_forest_rabbit animal_weight
scoreboard players operation #flower_forest_total animal_weight += #flower_forest_sheep animal_weight

scoreboard players set #forest_total animal_weight 0
scoreboard players operation #forest_total animal_weight += #forest_chicken animal_weight
scoreboard players operation #forest_total animal_weight += #forest_cow animal_weight
scoreboard players operation #forest_total animal_weight += #forest_pig animal_weight
scoreboard players operation #forest_total animal_weight += #forest_sheep animal_weight
scoreboard players operation #forest_total animal_weight += #forest_wolf animal_weight

scoreboard players set #forest_group_total animal_weight 0
scoreboard players operation #forest_group_total animal_weight += #forest_group_chicken animal_weight
scoreboard players operation #forest_group_total animal_weight += #forest_group_cow animal_weight
scoreboard players operation #forest_group_total animal_weight += #forest_group_pig animal_weight
scoreboard players operation #forest_group_total animal_weight += #forest_group_sheep animal_weight

scoreboard players set #frozen_ocean_group_total animal_weight 0
scoreboard players operation #frozen_ocean_group_total animal_weight += #frozen_ocean_group_polar_bear animal_weight

scoreboard players set #grove_total animal_weight 0
scoreboard players operation #grove_total animal_weight += #grove_fox animal_weight
scoreboard players operation #grove_total animal_weight += #grove_rabbit animal_weight
scoreboard players operation #grove_total animal_weight += #grove_wolf animal_weight

scoreboard players set #ice_spikes_group_total animal_weight 0
scoreboard players operation #ice_spikes_group_total animal_weight += #ice_spikes_group_polar_bear animal_weight
scoreboard players operation #ice_spikes_group_total animal_weight += #ice_spikes_group_rabbit animal_weight

scoreboard players set #jungle_total animal_weight 0
scoreboard players operation #jungle_total animal_weight += #jungle_chicken animal_weight
scoreboard players operation #jungle_total animal_weight += #jungle_cow animal_weight
scoreboard players operation #jungle_total animal_weight += #jungle_panda animal_weight
scoreboard players operation #jungle_total animal_weight += #jungle_parrot animal_weight
scoreboard players operation #jungle_total animal_weight += #jungle_pig animal_weight
scoreboard players operation #jungle_total animal_weight += #jungle_sheep animal_weight

scoreboard players set #mangrove_swamp_total animal_weight 0
scoreboard players operation #mangrove_swamp_total animal_weight += #mangrove_swamp_frog animal_weight

scoreboard players set #meadow_total animal_weight 0
scoreboard players operation #meadow_total animal_weight += #meadow_donkey animal_weight
scoreboard players operation #meadow_total animal_weight += #meadow_rabbit animal_weight
scoreboard players operation #meadow_total animal_weight += #meadow_sheep animal_weight

scoreboard players set #mushroom_fields_total animal_weight 0
scoreboard players operation #mushroom_fields_total animal_weight += #mushroom_fields_mooshroom animal_weight

scoreboard players set #peaks_group_total animal_weight 0
scoreboard players operation #peaks_group_total animal_weight += #peaks_group_goat animal_weight

scoreboard players set #plains_group_total animal_weight 0
scoreboard players operation #plains_group_total animal_weight += #plains_group_chicken animal_weight
scoreboard players operation #plains_group_total animal_weight += #plains_group_cow animal_weight
scoreboard players operation #plains_group_total animal_weight += #plains_group_donkey animal_weight
scoreboard players operation #plains_group_total animal_weight += #plains_group_horse animal_weight
scoreboard players operation #plains_group_total animal_weight += #plains_group_pig animal_weight
scoreboard players operation #plains_group_total animal_weight += #plains_group_sheep animal_weight

scoreboard players set #savanna_group_total animal_weight 0
scoreboard players operation #savanna_group_total animal_weight += #savanna_group_armadillo animal_weight
scoreboard players operation #savanna_group_total animal_weight += #savanna_group_chicken animal_weight
scoreboard players operation #savanna_group_total animal_weight += #savanna_group_cow animal_weight
scoreboard players operation #savanna_group_total animal_weight += #savanna_group_donkey animal_weight
scoreboard players operation #savanna_group_total animal_weight += #savanna_group_horse animal_weight
scoreboard players operation #savanna_group_total animal_weight += #savanna_group_pig animal_weight
scoreboard players operation #savanna_group_total animal_weight += #savanna_group_sheep animal_weight

scoreboard players set #savanna_plateau_total animal_weight 0
scoreboard players operation #savanna_plateau_total animal_weight += #savanna_plateau_armadillo animal_weight
scoreboard players operation #savanna_plateau_total animal_weight += #savanna_plateau_chicken animal_weight
scoreboard players operation #savanna_plateau_total animal_weight += #savanna_plateau_cow animal_weight
scoreboard players operation #savanna_plateau_total animal_weight += #savanna_plateau_donkey animal_weight
scoreboard players operation #savanna_plateau_total animal_weight += #savanna_plateau_horse animal_weight
scoreboard players operation #savanna_plateau_total animal_weight += #savanna_plateau_llama animal_weight
scoreboard players operation #savanna_plateau_total animal_weight += #savanna_plateau_pig animal_weight
scoreboard players operation #savanna_plateau_total animal_weight += #savanna_plateau_sheep animal_weight
scoreboard players operation #savanna_plateau_total animal_weight += #savanna_plateau_wolf animal_weight

scoreboard players set #snowy_slopes_total animal_weight 0
scoreboard players operation #snowy_slopes_total animal_weight += #snowy_slopes_goat animal_weight
scoreboard players operation #snowy_slopes_total animal_weight += #snowy_slopes_rabbit animal_weight

scoreboard players set #sparse_jungle_total animal_weight 0
scoreboard players operation #sparse_jungle_total animal_weight += #sparse_jungle_chicken animal_weight
scoreboard players operation #sparse_jungle_total animal_weight += #sparse_jungle_cow animal_weight
scoreboard players operation #sparse_jungle_total animal_weight += #sparse_jungle_pig animal_weight
scoreboard players operation #sparse_jungle_total animal_weight += #sparse_jungle_sheep animal_weight
scoreboard players operation #sparse_jungle_total animal_weight += #sparse_jungle_wolf animal_weight

scoreboard players set #swamp_total animal_weight 0
scoreboard players operation #swamp_total animal_weight += #swamp_chicken animal_weight
scoreboard players operation #swamp_total animal_weight += #swamp_cow animal_weight
scoreboard players operation #swamp_total animal_weight += #swamp_frog animal_weight
scoreboard players operation #swamp_total animal_weight += #swamp_pig animal_weight
scoreboard players operation #swamp_total animal_weight += #swamp_sheep animal_weight

scoreboard players set #taiga_group_total animal_weight 0
scoreboard players operation #taiga_group_total animal_weight += #taiga_group_chicken animal_weight
scoreboard players operation #taiga_group_total animal_weight += #taiga_group_cow animal_weight
scoreboard players operation #taiga_group_total animal_weight += #taiga_group_fox animal_weight
scoreboard players operation #taiga_group_total animal_weight += #taiga_group_pig animal_weight
scoreboard players operation #taiga_group_total animal_weight += #taiga_group_rabbit animal_weight
scoreboard players operation #taiga_group_total animal_weight += #taiga_group_sheep animal_weight
scoreboard players operation #taiga_group_total animal_weight += #taiga_group_wolf animal_weight

scoreboard players set #windswept_group_total animal_weight 0
scoreboard players operation #windswept_group_total animal_weight += #windswept_group_chicken animal_weight
scoreboard players operation #windswept_group_total animal_weight += #windswept_group_cow animal_weight
scoreboard players operation #windswept_group_total animal_weight += #windswept_group_llama animal_weight
scoreboard players operation #windswept_group_total animal_weight += #windswept_group_pig animal_weight
scoreboard players operation #windswept_group_total animal_weight += #windswept_group_sheep animal_weight

scoreboard players set #wooded_badlands_total animal_weight 0
scoreboard players operation #wooded_badlands_total animal_weight += #wooded_badlands_armadillo animal_weight
scoreboard players operation #wooded_badlands_total animal_weight += #wooded_badlands_chicken animal_weight
scoreboard players operation #wooded_badlands_total animal_weight += #wooded_badlands_cow animal_weight
scoreboard players operation #wooded_badlands_total animal_weight += #wooded_badlands_pig animal_weight
scoreboard players operation #wooded_badlands_total animal_weight += #wooded_badlands_sheep animal_weight
scoreboard players operation #wooded_badlands_total animal_weight += #wooded_badlands_wolf animal_weight

