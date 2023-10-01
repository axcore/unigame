---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("ethereal:coral3", {
	description = S("Orange Glow Coral"),
	drawtype = "plantlike",
	tiles = {"ethereal_coral_orange.png"},
	inventory_image = "ethereal_coral_orange.png",
	wield_image = "ethereal_coral_orange.png",
	paramtype = "light",
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 1 / 4, 6 / 16}
	},
	light_source = 3,
	groups = {snappy = 3},
	sounds = default.node_sound_leaves_defaults()
})
minetest.register_craft( {
	output = "dye:orange 3",
	recipe = {{"ethereal:coral3"}}
]]--
