---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nettle
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("nettle:carduus", {
	description = "Carduus",
	drawtype = "plantlike",
	waving = 1,
	visual_scale = 1.2,
	tiles = {"nettle_carduus.png"},
	inventory_image = "nettle_carduus.png",
	wield_image = "nettle_carduus.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	damage_per_second = 1 * damage_scaling_factor,
	groups = {snappy = 2, flora = 1, attached_node = 1, flammable = 1, nettle_weed = 1, oddly_breakable_by_hand = 2},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_craft({
	type = "fuel",
	recipe = "nettle:carduus",
	burntime = 3,
})
]]--
