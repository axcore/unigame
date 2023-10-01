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
minetest.register_craftitem("basic_materials:steel_wire", {
	description = S("Spool of steel wire"),
	groups = { wire = 1 },
	inventory_image = "basic_materials_steel_wire.png"
})
minetest.register_craft( {
	output = "basic_materials:steel_wire 2",
	type = "shapeless",
	recipe = {
		"default:steel_ingot",
		"basic_materials:empty_spool",
		"basic_materials:empty_spool",
	},
})
]]--
