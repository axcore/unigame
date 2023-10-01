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
minetest.register_craftitem("basic_materials:silicon", {
	description = S("Silicon lump"),
	inventory_image = "basic_materials_silicon.png",
})
minetest.register_craft( {
	output = "mesecons_materials:silicon 4",
	recipe = {
		{ "default:sand", "default:sand" },
		{ "default:sand", "default:steel_ingot" },
	},
})
]]--
