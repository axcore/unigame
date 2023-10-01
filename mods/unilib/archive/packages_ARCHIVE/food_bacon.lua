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
minetest.register_craftitem("bbq:bacon_raw", {
	description = ("Bacon Raw"),
	inventory_image = "bbq_bacon_raw.png",
	on_use = minetest.item_eat(3),
})
minetest.register_craft({
	output = "bbq:bacon_raw 2",
	type = "shapeless",
	recipe = {"bbq:liquid_smoke", "bbq:brine", "mobs:pork_raw"}
})

minetest.register_craftitem("bbq:bacon", {
	description = ("Bacon"),
	inventory_image = "bbq_bacon.png",
	on_use = minetest.item_eat(7),
})
minetest.register_craft({
	type = "cooking",
	output = "bbq:bacon",
	recipe = "bbq:bacon_raw",
	cooktime = 5,
})
]]--
