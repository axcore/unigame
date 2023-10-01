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
minetest.register_node("nettle:scotch_broom", {
	description = "Scotch Broom",
	drawtype = "mesh",
	mesh = "nettle_scotch_broom.obj",
	waving = 1,
	tiles = {"nettle_scotch_broom.png"},
	inventory_image = "nettle_scotch_broom.png",
	wield_image = "nettle_scotch_broom.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	groups = {choppy = 2, oddly_breakable_by_hand = 1, flora = 1, flammable = 1, nettle_weed = 1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_craft({
	type = "fuel",
	recipe = "nettle:scotch_broom",
	burntime = 6,
})
]]--
