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
minetest.register_craftitem("bbq:ham_raw", {
	description = ("Ham Raw"),
	inventory_image = "bbq_ham_raw.png",
	on_use = minetest.item_eat(4),
})
minetest.register_craft({
	output = "bbq:ham_raw 2",
	type = "shapeless",
	recipe = {"bbq:brine", "mobs:pork_raw", "group:food_honey"}
})

minetest.register_craftitem("bbq:ham", {
	description = ("Ham"),
	inventory_image = "bbq_ham.png",
	on_use = minetest.item_eat(9),
})
minetest.register_craft({
	type = "cooking",
	output = "bbq:ham",
	recipe = "bbq:ham_raw",
	cooktime = 10,
})
]]--
