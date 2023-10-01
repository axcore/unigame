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
minetest.register_craftitem("bbq:stuffed_chop_raw", {
	description = ("Stuffed Chop Raw"),
	inventory_image = "bbq_stuffed_chop_raw.png",
	on_use = minetest.item_eat(3),
})
minetest.register_craft({
	output = "bbq:stuffed_chop_raw 3",
	type = "shapeless",
	recipe = {"group:food_onion", "farming:bread", "flowers:mushroom_brown", "mobs:pork_raw", "default:apple"}
})

minetest.register_craftitem("bbq:stuffed_chop", {
	description = ("Stuffed Chop"),
	inventory_image = "bbq_stuffed_chop.png",
	on_use = minetest.item_eat(8),
})
minetest.register_craft({
	type = "cooking",
	output = "bbq:stuffed_chop",
	recipe = "bbq:stuffed_chop_raw",
	cooktime = 8,
})
]]--
