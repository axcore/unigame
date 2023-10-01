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
minetest.register_node("bbq:beef_map", {
	description = "Beef Map",
	inventory_image = "bbq_cow_map.png",
	tiles = {
		"default_junglewood.png", "default_junglewood.png",
		"default_junglewood.png", "default_junglewood.png",
		"default_junglewood.png", "bbq_cow_map.png",
	},

	paramtype2 = "facedir",
	paramtype = "light",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, 0.4, 0.5, 0.5, 0.5},

			},
		},
	groups = {choppy=3, oddly_breakable_by_hand=2, flammable=3},
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_craft( {
	output = "bbq:beef_map",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"group:wood", "mobs:leather", "group:wood"},
		{"group:wood", "group:wood", "group:wood"},
	}
})
]]--
