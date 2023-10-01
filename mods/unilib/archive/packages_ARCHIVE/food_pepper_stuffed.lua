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
minetest.register_craftitem("bbq:stuffed_pepper_raw", {
	description = ("Stuffed Pepper Raw"),
	inventory_image = "bbq_stuffed_pepper_raw.png",
	on_use = minetest.item_eat(4),
})
minetest.register_craft({
	output = "bbq:stuffed_pepper_raw 3",
	type = "shapeless",
	recipe = {"group:food_cheese", "farming:bread", "group:food_pepper"}
})

minetest.register_craftitem("bbq:stuffed_pepper", {
	description = ("Stuffed Pepper"),
	inventory_image = "bbq_stuffed_pepper.png",
	on_use = minetest.item_eat(9),
})
minetest.register_craft({
	type = "cooking",
	output = "bbq:stuffed_pepper",
	recipe = "bbq:stuffed_pepper_raw",
	cooktime = 4,
})
]]--
