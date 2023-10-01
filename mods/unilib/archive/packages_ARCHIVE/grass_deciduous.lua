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
minetest.register_node("mapgen:bush", {
	description = "Deciduous Forest Bush",
	drawtype = "firelike",
	tiles = {"mapgen_bush.png"},
	paramtype = "light",
	is_ground_content = false,
	sunlight_propagates = false,
	groups = {snappy=3, flammable=1, oddly_breakable_by_hand=1, leaves=1},
	visual_scale = 1.2,
	sounds = default.node_sound_leaves_defaults(),
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.4, -0.4, -0.4, 0.4, 0.4, 0.4}
	},
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = "default:dirt_with_grass",
	sidelen = 16,
	fill_ratio = 0.05,
	biomes = {"deciduous_forest2",},
	decoration = "mapgen:bush",
	height = 1,
})
]]--
