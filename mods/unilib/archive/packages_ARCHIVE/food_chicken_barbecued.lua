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
minetest.register_craftitem("bbq:bbq_chicken_raw", {
	description = ("BBQ Chicken Raw"),
	inventory_image = "bbq_bbq_chicken_raw.png",
	on_use = minetest.item_eat(4),
})
minetest.register_craft({
	output = "bbq:bbq_chicken_raw 3",
	type = "shapeless",
	recipe = {"bbq:bbq_sauce", "mobs:chicken_raw", "bbq:paprika"}
})

minetest.register_craftitem("bbq:bbq_chicken", {
	description = ("BBQ Chicken"),
	inventory_image = "bbq_bbq_chicken.png",
	on_use = minetest.item_eat(8),
})
minetest.register_craft({
	type = "cooking",
	output = "bbq:bbq_chicken",
	recipe = "bbq:bbq_chicken_raw",
	cooktime = 10,
})
]]--
