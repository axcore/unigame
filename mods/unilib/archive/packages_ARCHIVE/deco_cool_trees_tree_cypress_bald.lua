---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/baldcypress
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
if mg_name ~= "v6" and mg_name ~= "singlenode" then
	minetest.register_decoration({
		name = "baldcypress:baldcypress_tree",
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
		noise_params = {
			offset = 0.0005,
			scale = 0.0005,
			spread = {x = 250, y = 250, z = 250},
			seed = 678,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"coniferous_forest_ocean"},
		height = 2,
		y_min = 0,
		y_max = 0,
		schematic = modpath.."/schematics/baldcypress.mts",
		flags = "place_center_x, place_center_z, force_placement",
		rotation = "random",
	})
end
]]--
