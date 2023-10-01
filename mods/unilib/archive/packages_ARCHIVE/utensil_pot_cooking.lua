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
minetest.register_craftitem("farming:pot", {
	description = S("Cooking Pot"),
	inventory_image = "farming_pot.png",
	groups = {food_pot = 1, flammable = 2}
})
minetest.register_craft({
	output = "farming:pot",
	recipe = {
		{"group:stick", "default:steel_ingot", "default:steel_ingot"},
		{"", "default:steel_ingot", "default:steel_ingot"}
	}
})
]]--
