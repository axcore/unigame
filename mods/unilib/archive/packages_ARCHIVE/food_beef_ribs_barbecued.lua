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
minetest.register_craftitem("bbq:bbq_beef_ribs_raw", {
	description = ("BBQ Ribs Raw"),
	inventory_image = "bbq_beef_ribs_raw.png",
	on_use = minetest.item_eat(4),
})
minetest.register_craft({
	output = "bbq:bbq_beef_ribs_raw 2",
	type = "shapeless",
	recipe = {"bbq:bbq_sauce", "bbq:beef_raw", "group:food_pepper_ground"}
})

minetest.register_craftitem("bbq:bbq_beef_ribs", {
	description = ("BBQ Ribs"),
	inventory_image = "bbq_beef_ribs.png",
	on_use = minetest.item_eat(9),
})
minetest.register_craft({
	type = "cooking",
	output = "bbq:bbq_beef_ribs",
	recipe = "bbq:bbq_beef_ribs_raw",
	cooktime = 15,
})
]]--
