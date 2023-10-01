---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("underch:torchberries", {
	description = "Torchberries",
	tiles = {"underch_torchberries.png"},
	inventory_image = "underch_torchberries.png",
	wield_image = "underch_torchberries.png",
	drawtype = "plantlike",
	paramtype = "light",
	paramtype2 = "wallmounted",
	legacy_wallmounted = true,
	sunlight_propagates = true,
	walkable = false,
	groups = {snappy = 3, flammable = 1},
	sounds = default.node_sound_leaves_defaults(),
	light_source = 8,
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -5 / 16, -6 / 16, 6 / 16, 0.5, 6 / 16},
	}
})
minetest.register_craft({
	output = "default:torch 4",
	recipe = {
		{"underch:torchberries"},
		{"default:stick"}
	}
})
]]--
