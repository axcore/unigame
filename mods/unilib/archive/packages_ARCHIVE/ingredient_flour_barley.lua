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
minetest.register_craftitem("grains:barley_flour", {
	description = "Barley Flour",
	inventory_image = "grains_barley_flour.png",
	groups = {flammable = 1},
})
minetest.register_craft({
	type = "shapeless",
	output = "grains:barley_flour",
	recipe = {"grains:barley", "grains:barley", "grains:barley", "grains:barley"}
})
]]--
