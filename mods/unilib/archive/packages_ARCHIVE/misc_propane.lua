---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("bbq:propane", {
	description = ("Propane"),
	inventory_image = "bbq_propane.png",
	paramtype = "light",
	paramtype2 = "facedir",
	wield_image = "bbq_propane.png",
	drawtype = "plantlike",
	sunlight_propagates = true,
	tiles = {"bbq_propane.png"},
	groups = {explody = 1, dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_metal_defaults(),
})
minetest.register_craft({
	output = "bbq:propane",
	recipe = {
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "default:torch", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"}
	}
})
minetest.register_craft({
	type = "fuel",
	recipe = "bbq:propane",
	burntime = 500,
})
]]--
