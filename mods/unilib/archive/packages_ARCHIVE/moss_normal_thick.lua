---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("mapgen:moss", {
	description = "Moss",
	drawtype = "nodebox",
	tiles = {"mapgen_moss.png"},
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.4, 0.5},
		}
	},
	buildable_to = true,
	groups = {snappy = 3, oddly_breakable_by_hand=1, dig_immediate=3},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = "mapgen:dirt_with_junglegrass",
	sidelen = 16,
	fill_ratio = 0.05,
	biomes = {"rainforest",},
	decoration = "mapgen:moss",
	height = 1,
})
]]--
