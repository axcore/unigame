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
minetest.register_node("cropocalypse:carved_pumpkin", {
	description = "Carved Pumpkin",
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
		"cropocalypse_carved_pumpkin.png"
	},
	groups = {pumpkin = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 1},
	drop = "cropocalypse:carved_pumpkin",
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})
minetest.register_craft({
	type = "shapeless",
	output = "cropocalypse:carved_pumpkin",
	recipe = {"cropocalypse:pumpkin", "default:sword_wood"}
})
]]--
