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
minetest.register_craftitem("basic_materials:steel_strip", {
	description = S("Steel Strip"),
	groups = { strip = 1 },
	inventory_image = "basic_materials_steel_strip.png"
})
minetest.register_craft( {
	output = "basic_materials:steel_strip 12",
	recipe = {
		{ "", "default:steel_ingot", "" },
		{ "default:steel_ingot", "", "" },
	},
})
]]--
