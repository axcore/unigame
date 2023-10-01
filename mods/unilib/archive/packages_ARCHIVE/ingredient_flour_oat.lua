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
minetest.register_craftitem("grains:oat_flour", {
	description = "Oat Flour",
	inventory_image = "grains_oat_flour.png",
	groups = {flammable = 1},
})
minetest.register_craft({
	type = "shapeless",
	output = "grains:oat_flour",
	recipe = {"grains:oat", "grains:oat", "grains:oat", "grains:oat"}
})
]]--
