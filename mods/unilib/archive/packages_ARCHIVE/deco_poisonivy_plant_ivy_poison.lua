---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/poisonivy
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
biome_lib.register_active_spawner({
	spawn_delay = SPAWN_DELAY,
	spawn_plants = {"poisonivy:seedling"},
	avoid_radius = 10,
	spawn_chance = SPAWN_CHANCE/10,
	spawn_surfaces = {"default:dirt_with_grass"},
	avoid_nodes = {"group:poisonivy", "group:flower", "group:flora"},
	seed_diff = poisonivy_seed_diff,
	light_min = 7,
	alt_wallnode = "poisonivy:climbing",
	verticals_list = walls_list
})
]]--
