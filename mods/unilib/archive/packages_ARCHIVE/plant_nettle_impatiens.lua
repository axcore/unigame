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
minetest.register_node("nettle:impatiens", {
	description = "Impatiens",
	drawtype = "mesh",
	mesh = "nettle_nettle.obj",
	waving = 1,
	tiles = {"nettle_impatiens.png"},
	inventory_image = "nettle_impatiens.png",
	wield_image = "nettle_impatiens.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 2, flora = 1, attached_node = 1, flammable = 1, nettle_weed = 1, oddly_breakable_by_hand = 2},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_craft({
	type = "fuel",
	recipe = "nettle:impatiens",
	burntime = 3,
})
]]--
