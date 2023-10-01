---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/pomegranate
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
if mg_name ~= "v6" and mg_name ~= "singlenode" then
	minetest.register_decoration({
	name = "pomegranate:pomegranate_tree",
		deco_type = "schematic",
		place_on = {"default:dry_dirt"},
		sidelen = 16,
		noise_params = {
			offset = 0.0005,
			scale = 0.00004,
			spread = {x = 250, y = 250, z = 250},
			seed = 978,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"savanna"},
		y_min = 1,
		y_max = 80,
		schematic = modpath.."/schematics/pomegranate.mts",
		flags = "place_center_x, place_center_z,  force_placement",
		rotation = "random",
	})
end
]]--
