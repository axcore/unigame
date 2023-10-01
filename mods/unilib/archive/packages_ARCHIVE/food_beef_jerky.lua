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
minetest.register_craftitem("bbq:beef_jerky_raw", {
	description = ("Beef Jerky Raw"),
	inventory_image = "bbq_beef_jerky_raw.png",
	on_use = minetest.item_eat(2),
})
minetest.register_craft({
	output = "bbq:beef_jerky_raw 3",
	type = "shapeless",
	recipe = {"bbq:liquid_smoke", "bbq:brine", "bbq:beef_raw"}
})

minetest.register_craftitem("bbq:beef_jerky", {
	description = ("Beef Jerky"),
	inventory_image = "bbq_beef_jerky.png",
	on_use = minetest.item_eat(5),
})
minetest.register_craft({
	type = "cooking",
	output = "bbq:beef_jerky",
	recipe = "bbq:beef_jerky_raw",
	cooktime = 12,
})
]]--
