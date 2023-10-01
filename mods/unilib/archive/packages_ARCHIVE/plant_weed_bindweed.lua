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
minetest.register_node("mapgen:creeper", {
	description = "Creeper",
	drawtype = "firelike",
	tiles = {
		"mapgen_creeper.png",
		"mapgen_trans.png",
		"mapgen_creeper.png",
		"mapgen_creeper.png",
		"mapgen_creeper.png",
		"mapgen_creeper.png"
	},
	groups = {snappy=3, flammable=1, attached_node=1, flora=1},
	sounds = default.node_sound_leaves_defaults(),
	is_ground_content=true,
	buildable_to = true,
	sunlight_propagates = true,
	walkable = false,
	inventory_image = "mapgen_creeper.png",
	paramtype = "light",
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.1, 0.5}
	},
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = "default:dirt_with_grass",
	sidelen = 16,
	fill_ratio = 0.05,
	biomes = {"deciduous_forest2",},
	decoration = "mapgen:creeper",
	height = 1,
})
]]--
