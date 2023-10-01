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
minetest.register_node("mapgen:aloe_vera", {
	description = "Aloe Vera",
	drawtype = "plantlike",
	tiles = {"mapgen_aloe_vera.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true,
	sunlight_propagates = true,
	inventory_image = "mapgen_aloe_vera.png",
	groups = {snappy=3, flammable=1, attached_node=1, flora=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = "default:desert_sand",
	sidelen = 16,
	fill_ratio = 0.02,
	biomes = {"swamp",},
	decoration = "mapgen:aloe_vera",
	height = 1,
})
]]--
