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
minetest.register_craftitem("farming:cookie", {
	description = S("Cookie"),
	inventory_image = "farming_cookie.png",
	on_use = minetest.item_eat(2)
})
minetest.register_craft( {
	output = "farming:cookie 8",
	recipe = {
		{"group:food_wheat", "group:food_cocoa", "group:food_wheat" }
	}
})
]]--
