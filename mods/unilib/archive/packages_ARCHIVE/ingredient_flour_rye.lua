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
minetest.register_craftitem("grains:rye_flour", {
	description = "Rye Flour",
	inventory_image = "grains_rye_flour.png",
	groups = {flammable = 1},
})
minetest.register_craft({
	type = "shapeless",
	output = "grains:rye_flour",
	recipe = {"grains:rye", "grains:rye", "grains:rye", "grains:rye"}
})
]]--
