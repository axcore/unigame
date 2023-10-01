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
minetest.register_craftitem("bbq:hotdog_raw", {
	description = ("Hotdog Raw"),
	inventory_image = "bbq_hotdog_raw.png",
	on_use = minetest.item_eat(3),
})
minetest.register_craft({
	output = "bbq:hotdog_raw",
	type = "shapeless",
	recipe = {"mobs:pork_raw", "mobs:chicken_raw", "bbq:sawdust"}
})

minetest.register_craftitem("bbq:hotdog_cooked", {
	description = ("Hotdog Cooked"),
	inventory_image = "bbq_hotdog_cooked.png",
	on_use = minetest.item_eat(7),
})
minetest.register_craft({
	type = "cooking",
	output = "bbq:hotdog_cooked",
	recipe = "bbq:hotdog_raw",
	cooktime = 5,
})

minetest.register_craftitem("bbq:hotdog", {
	description = ("Hot Dog"),
	inventory_image = "bbq_hotdog.png",
	on_use = minetest.item_eat(8),
})
minetest.register_craft({
	output = "bbq:hotdog 2",
	type = "shapeless",
	recipe = {"bbq:hotdog_cooked", "farming:bread"}
})
]]--
