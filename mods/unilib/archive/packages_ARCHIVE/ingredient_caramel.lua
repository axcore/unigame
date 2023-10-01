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
minetest.register_craftitem("farming:caramel", {
	description = S("Caramel"),
	inventory_image = "farming_caramel.png",
})
minetest.register_craft({
	type = "cooking",
	cooktime = 6,
	output = "farming:caramel",
	recipe = "group:food_sugar",
})
]]--
