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
minetest.register_node("nettle:nettle", {
	description = "Nettle",
	drawtype = "mesh",
	mesh = "nettle_nettle.obj",
	waving = 1,
	tiles = {"nettle_nettle.png"},
	inventory_image = "nettle_nettle.png",
	wield_image = "nettle_nettle.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	damage_per_second = 1 * damage_scaling_factor,
	groups = {snappy = 2, flora = 1, attached_node = 1, flammable = 1, nettle_weed = 1, oddly_breakable_by_hand = 2},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
})
minetest.register_craft({
	type = "fuel",
	recipe = "nettle:nettle",
	burntime = 3,
})
]]--
