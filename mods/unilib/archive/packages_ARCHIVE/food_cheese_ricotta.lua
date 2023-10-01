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
minetest.register_craftitem("cheese:ricotta", {
	description = S("Ricotta"),
	inventory_image = "ricotta.png",
	on_use = minetest.item_eat(5),
	groups = {food_cheese = 1, food_cream = 1, food = 5},
})
minetest.register_craft({
	type = "cooking",
	output = "cheese:ricotta",
	recipe = "cheese:whey",
	cooktime = 15,
})
]]--
