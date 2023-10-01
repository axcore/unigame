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
minetest.register_craftitem("bbq:grilled_corn_raw", {
	description = ("Grilled Corn Raw"),
	inventory_image = "bbq_grilled_corn_raw.png",
	on_use = minetest.item_eat(5),
})
minetest.register_craft({
	output = "bbq:grilled_corn_raw 2",
	type = "shapeless",
	recipe = {"group:food_cheese", "bbq:paprika", "group:food_corn"}
})

minetest.register_craftitem("bbq:grilled_corn", {
	description = ("Grilled Corn"),
	inventory_image = "bbq_grilled_corn.png",
	on_use = minetest.item_eat(8),
})
minetest.register_craft({
	type = "cooking",
	output = "bbq:grilled_corn",
	recipe = "bbq:grilled_corn_raw",
	cooktime = 4,
})
]]--
