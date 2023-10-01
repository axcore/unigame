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
minetest.register_node("ethereal:dry_shrub", {
	description = S("Fiery Dry Shrub"),
	drawtype = "plantlike",
	tiles = {"ethereal_dry_shrub.png"},
	inventory_image = "ethereal_dry_shrub.png",
	wield_image = "ethereal_dry_shrub.png",
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

add_node({"ethereal:fiery_dirt"}, 0.10, {"fiery"}, 1, 100,
	{"ethereal:dry_shrub"}, nil, nil, nil, ethereal.fiery)
]]--
