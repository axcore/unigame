---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/ebony
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
if mg_name ~= "v6" and mg_name ~= "singlenode" then
	minetest.register_decoration({
		name = "ebony:ebony_tree",
		deco_type = "schematic",
		place_on = {"default:dirt_with_rainforest_litter"},
		sidelen = 16,
		noise_params = {
			offset = 0.005,
			scale = 0.002,
			spread = {x = 250, y = 250, z = 250},
			seed = 1007,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"rainforest"},
		height = 2,
		y_min = 1,
		y_max = 62,
		schematic = modpath.."/schematics/ebony.mts",
		flags = "place_center_x, place_center_z, force_placement",
		rotation = "random",
		place_offset_y = 0,
	})
end
]]--
