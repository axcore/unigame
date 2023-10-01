---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("bbq:grilled_pizza_raw", {
	description = ("Grilled Pizza Raw"),
	inventory_image = "bbq_grilled_pizza_raw.png",
	on_use = minetest.item_eat(5),
})
minetest.register_craft({
	output = "bbq:grilled_pizza_raw 3",
	type = "shapeless",
	recipe = {"group:food_cheese", "group:food_pepper", "bbq:grilled_tomato", "flowers:mushroom_brown", "group:food_salt", "farming:wheat", "bbq:yeast"}
})

minetest.register_craftitem("bbq:grilled_pizza", {
	description = ("Grilled Pizza"),
	inventory_image = "bbq_grilled_pizza.png",
	on_use = minetest.item_eat(8),
})
minetest.register_craft({
	type = "cooking",
	output = "bbq:grilled_pizza",
	recipe = "bbq:grilled_pizza_raw",
	cooktime = 5,
})
]]--
