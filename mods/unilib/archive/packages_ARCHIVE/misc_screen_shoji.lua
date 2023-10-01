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
minetest.register_node("ethereal:paper_wall", {
	drawtype = "nodebox",
	description = S("Paper Wall"),
	tiles = {"ethereal_paper_wall.png"},
	inventory_image_image = "ethereal_paper_wall.png",
	wield_image = "ethereal_paper_wall.png",
	paramtype = "light",
	groups = {snappy = 3},
	sounds = default.node_sound_wood_defaults(),
	walkable = true,
	is_ground_content = false,
	sunlight_propagates = true,
	paramtype2 = "facedir",
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 5/11, 0.5, 0.5, 8/16}
	},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 5/11, 0.5, 0.5, 8/16}
		}
	}
})
minetest.register_craft({
	output = "ethereal:paper_wall",
	recipe = {
		{"group:stick", "default:paper", "group:stick"},
		{"group:stick", "default:paper", "group:stick"},
		{"group:stick", "default:paper", "group:stick"}
	}
})
]]--
