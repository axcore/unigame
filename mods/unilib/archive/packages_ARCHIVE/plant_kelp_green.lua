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
minetest.register_node("mapgen:kelp1", {
	description = "Kelp",
	drawtype = "plantlike",
	tiles = {"mapgen_kelp.png"},
	paramtype = "light",
	is_ground_content = false,
	sunlight_propagates = true,
	waving = 1,
	inventory_image = "mapgen_kelp.png",
	groups = {snappy=3, flammable=1, attached_node=1, sea=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, 0.5, 0.2}
	},
	walkable = false,
})

minetest.register_node("mapgen:kelp2", {
	description = "Kelp",
	drawtype = "plantlike",
	tiles = {"mapgen_kelp_2.png"},
	paramtype = "light",
	is_ground_content = false,
	sunlight_propagates = true,
	waving = 1,
	inventory_image = "mapgen_kelp.png",
	groups = {snappy=3, flammable=1, attached_node=1, sea=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, 0.5, 0.2}
	},
	walkable = false,
})
]]--
