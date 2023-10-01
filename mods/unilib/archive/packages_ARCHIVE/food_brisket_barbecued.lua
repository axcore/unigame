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
minetest.register_craftitem("bbq:brisket_raw", {
	description = ("BBQ Brisket Raw"),
	inventory_image = "bbq_brisket_raw.png",
	on_use = minetest.item_eat(4),
})
minetest.register_craft({
	output = "bbq:brisket_raw 2",
	type = "shapeless",
	recipe = {"bbq:bbq_sauce", "bbq:molasses", "bbq:beef_raw", "group:food_garlic_clove"}
})

minetest.register_craftitem("bbq:brisket", {
	description = ("BBQ Brisket"),
	inventory_image = "bbq_brisket.png",
	on_use = minetest.item_eat(9),
})
minetest.register_craft({
	type = "cooking",
	output = "bbq:brisket",
	recipe = "bbq:brisket_raw",
	cooktime = 15,
})
]]--
