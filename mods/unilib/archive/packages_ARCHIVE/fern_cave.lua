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
minetest.register_node("mapgen:cavefern1", {
	description = "Cave Fern",
	drawtype = "plantlike",
	tiles = {
		"mapgen_cavefern.png",
	},
	groups = {snappy=3, flammable=1, attached_node=1, flora=1},
	sounds = default.node_sound_leaves_defaults(),
	is_ground_content=true,
	buildable_to = true,
	walkable = false,
	inventory_image = "mapgen_cavefern.png",
	paramtype = "light",
	sunlight_propagates=true,
	selection_box = {
		type = "fixed",
		fixed = {-0.5, 0.1, -0.5, 0.5, 0.5, 0.5}
	},
})

minetest.register_node("mapgen:cavefern2", {
	description = "Cave Fern",
	drawtype = "plantlike",
	tiles = {
		"mapgen_cavefern2.png",
	},
	groups = {snappy=3, flammable=1, attached_node=1, flora=1},
	sounds = default.node_sound_leaves_defaults(),
	is_ground_content=true,
	buildable_to = true,
	walkable = false,
	inventory_image = "mapgen_cavefern2.png",
	paramtype = "light",
	sunlight_propagates=true,
	selection_box = {
		type = "fixed",
		fixed = {-0.5, 0.1, -0.5, 0.5, 0.5, 0.5}
	},
})

]]--
