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
minetest.register_node("mapgen:jungletree", {
	description = "Small Jungle Tree",
	drawtype = "plantlike",
	tiles = {"mapgen_jungletree.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true,
	sunlight_propagates = true,
	inventory_image = "mapgen_jungletree.png",
	visual_scale = 2,
	wield_scale = {x=0.5, y=0.5, z=0.5},
	groups = {snappy=3, flammable=1, attached_node=1, flora=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, 1, 0.2}
	},
	walkable = false,
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = "mapgen:dirt_with_junglegrass",
	sidelen = 16,
	fill_ratio = 0.02,
	biomes = {"rainforest",},
	decoration = "mapgen:jungletree",
	height = 1,
})
]]--
