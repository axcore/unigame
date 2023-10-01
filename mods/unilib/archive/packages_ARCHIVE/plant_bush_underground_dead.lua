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
minetest.register_node("underch:dead_bush", {
	description = "Underground Dead Bush",
	tiles = {"underch_underground_dead_bush.png"},
	inventory_image = "underch_underground_dead_bush.png",
	wield_image = "underch_underground_dead_bush.png",
	drawtype = "plantlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	groups = {snappy = 3, attached_node = 1, flammable = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 5 / 16, 6 / 16},
	}
})
minetest.register_craft({
	type = "fuel",
	recipe = "underch:dead_bush",
	burntime = 5,
})
minetest.register_craft({
	type = "shapeless",
	output = "default:stick",
	recipe = {"underch:dead_bush"},
})
]]--
