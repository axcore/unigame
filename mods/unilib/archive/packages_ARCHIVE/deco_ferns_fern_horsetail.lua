---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/ferns
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
if abstract_ferns.config.enable_horsetails_spawning == true then
	biome_lib.register_active_spawner({
		spawn_delay = 1200,
		spawn_plants = node_names,
		spawn_chance = 400,
		spawn_surfaces = {
			"default:dirt_with_grass",
			"default:dirt_with_coniferous_litter", -- minetest >= 0.5
			"default:desert_sand",
			"default:sand",
			"dryplants:grass_short",
			"stoneage:grass_with_silex",
			"default:mossycobble",
			"default:gravel"
		},
		seed_diff = 329,
		min_elevation = 1, -- above sea level
		near_nodes = {"default:water_source","default:river_water_source","default:gravel"},
		near_nodes_size = 2,
		near_nodes_vertical = 1,
		near_nodes_count = 1,
		--random_facedir = { 0, 179 },
	})
end
]]--
