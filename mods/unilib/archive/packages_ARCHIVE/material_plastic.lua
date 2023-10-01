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
minetest.register_craftitem("basic_materials:plastic_sheet", {
	description = S("Plastic sheet"),
	inventory_image = "basic_materials_plastic_sheet.png",
})
minetest.register_craft({
	type = "cooking",
	output = "basic_materials:plastic_sheet",
	recipe = "basic_materials:paraffin",
})
minetest.register_craft({
	type = "fuel",
	recipe = "basic_materials:plastic_sheet",
	burntime = 30,
})

minetest.register_craftitem("basic_materials:plastic_strip", {
	description = S("Plastic strips"),
	groups = { strip = 1 },
	inventory_image = "basic_materials_plastic_strip.png",
})
minetest.register_craft( {
    output = "basic_materials:plastic_strip 9",
    recipe = {
		{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" }
    },
})
]]--
