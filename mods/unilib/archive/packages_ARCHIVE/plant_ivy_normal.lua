---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
xdecor.register("ivy", {
	description = S("Ivy"),
	drawtype = "signlike",
	walkable = false,
	climbable = true,
	groups = {snappy = 3, flora = 1, attached_node = 1, plant = 1, flammable = 3},
	paramtype2 = "wallmounted",
	selection_box = {type="wallmounted"},
	tiles = {"xdecor_ivy.png"},
	inventory_image = "xdecor_ivy.png",
	wield_image = "xdecor_ivy.png",
	sounds = default.node_sound_leaves_defaults()
})
minetest.register_craft({
	output = "xdecor:ivy 4",
	recipe = {
		{"group:leaves"},
		{"group:leaves"}
	}
})
]]--
