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
minetest.register_node("bbq:charcoal_bag", {
	description = ("Bag o' Charcoal"),
	inventory_image = "bbq_charcoal_bag.png",
	wield_image = "bbq_charcoal_bag.png",
	drawtype = "plantlike",
	sunlight_propagates = true,
	tiles = {
		"bbq_charcoal_bag_top.png", "bbq_charcoal_bag_top.png",
		"bbq_charcoal_bag_side.png", "bbq_charcoal_bag_side.png",
		"bbq_charcoal_bag_back.png", "bbq_charcoal_bag.png",
	},
	groups = {dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	paramtype = "light",
	paramtype2 = "facedir",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
				{-0.21, -0.5, -0.1, 0.21, 0.22, 0.1},
				{-0.235, 0.22, -0.025, 0.235, 0.25, 0.025},
			},
		},
})
minetest.register_craft({
	output = "bbq:charcoal_bag",
	recipe = {
		{"bbq:charcoal_briquette", "bbq:charcoal_briquette", "bbq:charcoal_briquette"},
		{"bbq:charcoal_briquette", "bbq:charcoal_briquette", "bbq:charcoal_briquette"},
		{"bbq:charcoal_briquette", "bbq:charcoal_briquette", "bbq:charcoal_briquette"}
	}
})
minetest.register_craft({
	type = "fuel",
	recipe = "bbq:charcoal_bag",
	burntime = 150,
})
]]--
