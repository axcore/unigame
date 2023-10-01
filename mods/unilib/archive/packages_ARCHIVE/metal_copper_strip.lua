---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("basic_materials:copper_strip", {
	description = S("Copper Strip"),
	groups = { strip = 1 },
	inventory_image = "basic_materials_copper_strip.png"
})
minetest.register_craft( {
	output = "basic_materials:copper_strip 12",
	recipe = {
		{ "", "default:copper_ingot", "" },
		{ "default:copper_ingot", "", "" },
	},
})
]]--
