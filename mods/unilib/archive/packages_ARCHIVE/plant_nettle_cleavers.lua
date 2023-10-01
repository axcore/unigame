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
minetest.register_node("nettle:cleavers", {
	description = "Cleavers",
	drawtype = "mesh",
	mesh = "nettle_nettle.obj",
	waving = 1,
	tiles = {"nettle_cleavers.png"},
	inventory_image = "nettle_cleavers.png",
	wield_image = "nettle_cleavers.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	liquidtype = "source",
	liquid_alternative_flowing = "nettle:cleavers",
	liquid_alternative_source = "nettle:cleavers",
	liquid_renewable = false,
	liquid_range = 0,
	liquid_viscosity = 3,
	groups = {snappy = 2, flora = 1, attached_node = 1, flammable = 1, nettle_weed = 1, oddly_breakable_by_hand = 2},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_craft({
	type = "fuel",
	recipe = "nettle:cleavers",
	burntime = 3,
})
]]--
