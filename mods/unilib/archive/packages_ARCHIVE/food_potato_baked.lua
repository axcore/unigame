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
minetest.register_craftitem("farming:baked_potato", {
	description = S("Baked Potato"),
	inventory_image = "farming_baked_potato.png",
	on_use = minetest.item_eat(6)
})
minetest.register_craft({
	type = "cooking",
	cooktime = 10,
	output = "farming:baked_potato",
	recipe = "group:food_potato"
})
]]--
