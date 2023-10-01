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
xdecor.register("tatami", {
	description = S("Tatami"),
	tiles = {"xdecor_tatami.png"},
	wield_image = "xdecor_tatami.png",
	groups = {snappy = 3, flammable = 3},
	sunlight_propagates = true,
	node_box = xdecor.nodebox.slab_y(0.0625)
})
minetest.register_craft({
	output = "xdecor:tatami",
	recipe = {
		{"farming:wheat", "farming:wheat", "farming:wheat"}
	}
})
]]--
