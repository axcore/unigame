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
minetest.register_craftitem("cheese:mozzarella", {
	description = S("Mozzarella"),
	inventory_image = "mozzarella.png",
	on_use = minetest.item_eat(4),
	groups = {food = 4, food_cheese = 1},
})
minetest.register_craft({
	output = "cheese:mozzarella 4",
	recipe = {
		{"", "cheese:stretched_cheese", ""},
		{"cheese:stretched_cheese", "cheese:stretched_cheese", "cheese:stretched_cheese"},
		{"", "cheese:stretched_cheese", ""},
	}
})
]]--
