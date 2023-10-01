---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("farming:juicer", {
	description = S("Juicer"),
	inventory_image = "farming_juicer.png",
	groups = {food_juicer = 1, flammable = 2}
})
minetest.register_craft({
	output = "farming:juicer",
	recipe = {
		{"", "default:stone", ""},
		{"default:stone", "", "default:stone"}
	}
})
]]--
