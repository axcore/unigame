---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("decoblocks:spikes", {
	description = "Spikes",
	drawtype = "firelike",
	tiles = {
		"decoblocks_spikes.png"
	},
	wield_image = "decoblocks_spikes.png",
	inventory_image = "decoblocks_spikes.png",
	groups = {cracky=3},
	paramtype = "light",
	walkable = false,
	damage_per_second = 3,
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3, 0.5}
	},
	collision_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.2, 0.5}
	}
})
minetest.register_craft({
	output = 'decoblocks:spikes 3',
	recipe = {
		{'', 'default:steel_ingot', ''},
		{'default:steel_ingot', '', 'default:steel_ingot'},
	}
})
]]--
