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
minetest.register_craftitem("bbq:london_broil_raw", {
	description = ("London Broil Raw"),
	inventory_image = "bbq_london_broil_raw.png",
	on_use = minetest.item_eat(3),
})
minetest.register_craft({
	output = "bbq:london_broil_raw 2",
	type = "shapeless",
	recipe = {"bbq:bacon", "group:food_garlic_clove", "bbq:beef_raw"}
})

minetest.register_craftitem("bbq:london_broil", {
	description = ("London Broil"),
	inventory_image = "bbq_london_broil.png",
	on_use = minetest.item_eat(7),
})
minetest.register_craft({
	type = "cooking",
	output = "bbq:london_broil",
	recipe = "bbq:london_broil_raw",
	cooktime = 6,
})
]]--
