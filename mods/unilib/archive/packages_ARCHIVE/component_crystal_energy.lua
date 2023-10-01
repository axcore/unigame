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
minetest.register_craftitem("basic_materials:energy_crystal_simple", {
	description = S("Simple energy crystal"),
	inventory_image = "basic_materials_energy_crystal.png",
})
minetest.register_craft({
	--type = "shapeless",
	output = "basic_materials:energy_crystal_simple 2",
	recipe = {
		{ "default:mese_crystal_fragment", "default:torch", "default:mese_crystal_fragment" },
		{ "default:diamond", "default:gold_ingot", "default:diamond" }
	},
})
]]--
