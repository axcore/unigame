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
minetest.register_node("bbq:sawdust", {
	description = ("Saw Dust"),
	inventory_image = "bbq_sawdust.png",
	wield_image = "bbq_sawdust.png",
	drawtype = "plantlike",
	tiles = {
		"bbq_sawdust.png",
	},
	groups = {choppy=3, oddly_breakable_by_hand=2, flammable=3},
	sounds = default.node_sound_leaves_defaults(),
	paramtype = "light",
	paramtype2 = "facedir",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
			},
		},
})
minetest.register_craft({
	output = "bbq:sawdust",
	type = "shapeless",
	recipe = {"default:stick"},
})
]]--
