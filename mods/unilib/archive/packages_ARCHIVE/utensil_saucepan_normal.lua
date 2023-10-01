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
minetest.register_craftitem("farming:saucepan", {
	description = S("Saucepan"),
	inventory_image = "farming_saucepan.png",
	groups = {food_saucepan = 1, flammable = 2}
})
minetest.register_craft({
	output = "farming:saucepan",
	recipe = {
		{"default:steel_ingot", "", ""},
		{"", "group:stick", ""}
	}
})
]]--
