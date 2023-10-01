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
minetest.register_craftitem("basic_materials:copper_wire", {
	description = S("Spool of copper wire"),
	groups = { wire = 1 },
	inventory_image = "basic_materials_copper_wire.png"
})
minetest.register_craft( {
	output = "basic_materials:copper_wire 2",
	type = "shapeless",
	recipe = {
		"default:copper_ingot",
		"basic_materials:empty_spool",
		"basic_materials:empty_spool",
	},
})
]]--
