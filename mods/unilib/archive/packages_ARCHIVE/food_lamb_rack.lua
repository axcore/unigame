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
minetest.register_craftitem("bbq:rack_lamb_raw", {
	description = ("Rack of Lamb Raw"),
	inventory_image = "bbq_rack_lamb_raw.png",
	on_use = minetest.item_eat(5),
})
minetest.register_craft({
	output = "bbq:rack_lamb_raw 2",
	type = "shapeless",
	recipe = {"bbq:bbq_sauce", "mobs:mutton_raw", "mobs:mutton_raw"}
})

minetest.register_craftitem("bbq:rack_lamb", {
	description = ("Rack of Lamb"),
	inventory_image = "bbq_rack_lamb.png",
	on_use = minetest.item_eat(10),
})
minetest.register_craft({
	type = "cooking",
	output = "bbq:rack_lamb",
	recipe = "bbq:rack_lamb_raw",
	cooktime = 10,
})
]]--
