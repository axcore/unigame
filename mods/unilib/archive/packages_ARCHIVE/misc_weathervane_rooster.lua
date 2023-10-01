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
xdecor.register("rooster", {
	description = S("Rooster"),
	drawtype = "torchlike",
	inventory_image = "xdecor_rooster.png",
	walkable = false,
	groups = {snappy = 3, attached_node = 1},
	tiles = {"xdecor_rooster.png"},
})
minetest.register_craft({
	output = "xdecor:rooster",
	recipe = {
		{"default:gold_ingot", "", "default:gold_ingot"},
		{"", "default:gold_ingot", ""},
		{"default:gold_ingot", "", "default:gold_ingot"}
	}
})
]]--
