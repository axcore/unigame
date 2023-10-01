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
minetest.register_node("ethereal:firethorn", {
	description = S("Firethorn Shrub"),
	drawtype = "plantlike",
	tiles = {"ethereal_firethorn.png"},
	inventory_image = "ethereal_firethorn.png",
	wield_image = "ethereal_firethorn.png",
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flora = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 4 / 16, 5 / 16}
	}
})

add_node({"default:snowblock"}, 0.001, {"glacier"}, 1, 30,
	{"ethereal:firethorn"}, nil, nil, nil, ethereal.glacier)
]]--
