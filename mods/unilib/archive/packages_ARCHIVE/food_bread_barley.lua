---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    grains
-- Code:    MIT
-- Media:   CC BY 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("grains:barley_bread", {
	description = "Barley Bread",
	inventory_image = "grains_barley_bread.png",
	on_use = minetest.item_eat(5),
	groups = {flammable = 2},
})
minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "grains:barley_bread",
	recipe = "grains:barley_flour"
})
minetest.register_craft({
	type = "fuel",
	recipe = "grains:barley_bread",
	burntime = 1,
})
]]--
