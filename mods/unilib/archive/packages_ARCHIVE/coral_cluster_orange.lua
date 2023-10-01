---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("australia:cluster_coral_orange", {
	description = "Acropora millepora: Cluster Coral",
	drawtype = "plantlike",
	tiles = {"aus_cluster_coral_orange.png"},
	inventory_image = "aus_cluster_coral_orange.png",
	wield_image = "aus_cluster_coral_orange.png",
	paramtype = "light",
	walkable = false,
	climable = true,
	drowning = 1,
	is_ground_content = true,
	groups = {cracky = 3, coral = 1, stone = 1, attached_node = 1, sea = 1},
	sounds = default.node_sound_stone_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})
]]--
