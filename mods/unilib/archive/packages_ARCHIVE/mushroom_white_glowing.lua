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
minetest.register_node("mapgen:glowing_mushroom_white", {
	description = "White Glowing Mushroom",
	drawtype = "plantlike",
	tiles = {"mapgen_glowing_mushroom_white.png"},
	paramtype = "light",
	light_source = 9,
	is_ground_content = false,
	buildable_to = true,
	sunlight_propagates = true,
	inventory_image = "mapgen_glowing_mushroom_white.png",
	groups = {snappy=3, flammable=1, attached_node=1, flora=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
})
]]--
