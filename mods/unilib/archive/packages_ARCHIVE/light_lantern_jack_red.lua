---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("cropocalypse:jack_olantern", {
	description = "Jack O'Lantern",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		}
	},
	tiles = {
		"cropocalypse_pumpkin_top.png",
		"cropocalypse_pumpkin_bottom.png",
		"cropocalypse_pumpkin.png",
		"cropocalypse_pumpkin.png",
		"cropocalypse_pumpkin.png",
		"cropocalypse_jack_olantern.png"
	},
	groups = {pumpkin = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 1},
	drop = "cropocalypse:jack_olantern",
	sounds = default.node_sound_wood_defaults(),
	light_source = 11,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})
minetest.register_craft({
	type = "shapeless",
	output = "cropocalypse:jack_olantern",
	recipe = {"cropocalypse:carved_pumpkin", "default:torch"}
})
]]--
