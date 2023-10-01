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
minetest.register_craftitem("grains:rye_bread", {
	description = "Rye Bread",
	inventory_image = "grains_rye_bread.png",
	on_use = minetest.item_eat(5),
	groups = {flammable = 2},
})
minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "grains:rye_bread",
	recipe = "grains:rye_flour"
})
minetest.register_craft({
	type = "fuel",
	recipe = "grains:rye_bread",
	burntime = 1,
})
]]--
