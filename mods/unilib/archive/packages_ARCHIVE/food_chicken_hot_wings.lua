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
minetest.register_craftitem("bbq:hot_wings_raw", {
	description = ("Hot Wings Raw"),
	inventory_image = "bbq_hot_wings_raw.png",
	on_use = minetest.item_eat(3),
})
minetest.register_craft({
	output = "bbq:hot_wings_raw 3",
	type = "shapeless",
	recipe = {"bbq:hot_sauce", "mobs:chicken_raw", "bbq:paprika"}
})

minetest.register_craftitem("bbq:hot_wings", {
	description = ("Hot Wings"),
	inventory_image = "bbq_hot_wings.png",
	on_use = minetest.item_eat(8),
})
minetest.register_craft({
	type = "cooking",
	output = "bbq:hot_wings",
	recipe = "bbq:hot_wings_raw",
	cooktime = 7,
})
]]--
