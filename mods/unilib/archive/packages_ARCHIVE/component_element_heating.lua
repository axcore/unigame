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
minetest.register_craftitem("basic_materials:heating_element", {
	description = S("Heating element"),
	inventory_image = "basic_materials_heating_element.png",
})
minetest.register_craft( {
    output = "basic_materials:heating_element 2",
    recipe = {
		{ "default:copper_ingot", "default:mese_crystal_fragment", "default:copper_ingot" }
    },
})
]]--
