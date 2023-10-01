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
minetest.register_craftitem("basic_materials:padlock", {
	description = S("Padlock"),
	inventory_image = "basic_materials_padlock.png"
})
minetest.register_craft( {
	output = "basic_materials:padlock 2",
	recipe = {
		{ "basic_materials:steel_bar" },
		{ "default:steel_ingot" },
		{ "default:steel_ingot" },
	},
})
]]--
