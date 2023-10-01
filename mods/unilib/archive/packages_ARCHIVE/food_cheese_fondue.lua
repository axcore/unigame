---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cheese
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED / CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("cheese:fondue", {
	description = S("Fondue"),
	inventory_image = "fondue.png",
	on_use = minetest.item_eat(8, "default:copper_ingot 3"),
	groups = {food = 8},
})
minetest.register_craft({
	output = "cheese:fondue",
	recipe = {
		{"group:food_cheese", "", "group:food_cheese"},
		{"default:copper_ingot", "group:food_cheese", "default:copper_ingot"},
		{"", "default:copper_ingot", ""},
	}
})
]]--
