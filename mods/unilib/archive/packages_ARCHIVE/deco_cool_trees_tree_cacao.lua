---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/cacaotree
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
if mg_name ~= "v6" and mg_name ~= "singlenode" then

	minetest.register_decoration({
		name = "cacao:cacaotree",
		deco_type = "schematic",
		place_on = {"default:dirt_with_rainforest_litter"},
		sidelen = 16,
		noise_params = {
			offset = 0.001,
			scale = 0.001,
			spread = {x = 250, y = 250, z = 250},
			seed = 6431,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"rainforest"},
		y_min = 1,
		y_max = 31000,
		schematic = modpath.."/schematics/cacaotree.mts",
		flags = "place_center_x, place_center_z, force_placement",
		rotation = "random",
		place_offset_y = 1,
	})
end
]]--
