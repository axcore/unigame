---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    steel
-- Code:    GPL-2.0
-- Media:   CC-BY-SA-4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("steel:scrap", {
	description = "Steel scrap",
	inventory_image = "steel_scrap.png",
})
	minetest.register_craft({
		output = "default:iron_lump",
		recipe = {{"steel:scrap", "steel:scrap"}}
	})
]]--
