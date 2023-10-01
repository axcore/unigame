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
minetest.register_craftitem("basic_materials:gear_steel", {
	description = S("Steel gear"),
	inventory_image = "basic_materials_gear_steel.png"
})
minetest.register_craft( {
	output = "basic_materials:gear_steel 6",
	recipe = {
		{ "", "default:steel_ingot", "" },
		{ "default:steel_ingot","basic_materials:chainlink_steel", "default:steel_ingot" },
		{ "", "default:steel_ingot", "" }
	},
})
]]--
