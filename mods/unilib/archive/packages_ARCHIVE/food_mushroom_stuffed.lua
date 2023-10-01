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
minetest.register_craftitem("bbq:stuffed_mushroom_raw", {
	description = ("Stuffed Mushroom Raw"),
	inventory_image = "bbq_stuffed_mushroom_raw.png",
	on_use = minetest.item_eat(5),
})
minetest.register_craft({
	output = "bbq:stuffed_mushroom_raw 2",
	type = "shapeless",
	recipe = {"group:food_tomato", "farming:bread", "flowers:mushroom_brown"}
})

minetest.register_craftitem("bbq:stuffed_mushroom", {
	description = ("Stuffed Mushroom"),
	inventory_image = "bbq_stuffed_mushroom.png",
	on_use = minetest.item_eat(9),
})
minetest.register_craft({
	type = "cooking",
	output = "bbq:stuffed_mushroom",
	recipe = "bbq:stuffed_mushroom_raw",
	cooktime = 6,
})
]]--
