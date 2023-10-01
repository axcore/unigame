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
minetest.register_craftitem("bbq:beef_raw", {
	description = ("Raw Beef"),
	inventory_image = "bbq_beef_raw.png",
	on_use = minetest.item_eat(3),
})

minetest.register_craftitem("bbq:beef", {
	description = ("Beef"),
	inventory_image = "bbq_beef_cooked.png",
	on_use = minetest.item_eat(8),
})
minetest.register_craft({
	type = "cooking",
	output = "bbq:beef",
	recipe = "bbq:beef_raw",
	cooktime = 5,
})
]]--
