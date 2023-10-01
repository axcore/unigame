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
minetest.register_node("mapgen:cattail", {
	description = "Cattail",
	drawtype = "plantlike",
	tiles = {"mapgen_cattail.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true,
	sunlight_propagates = true,
	inventory_image = "mapgen_cattail.png",
	visual_scale = 2,
	wield_scale = {x=0.5, y=0.5, z=0.5},
	groups = {snappy=3, flammable=1, attached_node=1, flora=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 1, 0.3}
	},
	walkable = false,
})
]]--
