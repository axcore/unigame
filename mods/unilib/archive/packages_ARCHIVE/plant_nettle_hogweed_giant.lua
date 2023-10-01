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
minetest.register_node("nettle:giant_hogweed", {
	description = "Giant Hogweed",
	drawtype = "plantlike",
	waving = 1,
	visual_scale = 2,
	tiles = {"nettle_giant_hogweed.png"},
	inventory_image = "nettle_giant_hogweed.png",
	wield_image = "nettle_giant_hogweed.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	damage_per_second = 2 * damage_scaling_factor,
	on_punch = function(pos, node, player, pointed_thing)
		player:set_hp(player:get_hp() - 1)
	end,
	groups = {snappy = 2, flora = 1, attached_node = 1, flammable = 1, nettle_weed = 1, oddly_breakable_by_hand = 2},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_craft({
	type = "fuel",
	recipe = "nettle:giant_hogweed",
	burntime = 3,
})
]]--
