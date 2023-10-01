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
minetest.register_craftitem("bbq:corned_beef_raw", {
	description = ("Corned Beef Raw"),
	inventory_image = "bbq_corned_beef_raw.png",
	on_use = minetest.item_eat(5),
})
minetest.register_craft({
	output = "bbq:corned_beef_raw",
	type = "shapeless",
	recipe = {"group:food_peppercorn", "bbq:beef_raw","bbq:brine",}
})

minetest.register_craftitem("bbq:corned_beef", {
	description = ("Corned Beef"),
	inventory_image = "bbq_corned_beef.png",
	on_use = minetest.item_eat(10),
})
minetest.register_craft({
	type = "cooking",
	output = "bbq:corned_beef",
	recipe = "bbq:corned_beef_raw",
	cooktime = 15,
})
]]--
