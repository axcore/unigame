---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    steel
-- Code:    GPL-2.0
-- Media:   CC-BY-SA-4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("steel:grate_soft", {
	description = "Soft Steel Grate",
	drawtype = "fencelike",
	tiles = {"steel_grate_soft.png"},
	inventory_image = "steel_grate_soft_inventory.png",
	wield_image = "steel_grate_soft_inventory.png",
	paramtype = "light",
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	sounds = sound_api.node_sound_wood_defaults(),
	groups = {cracky = 2, choppy = 2, dig_stone = 1},
})
	minetest.register_craft({
		output = "steel:grate_soft 3",
		recipe = {
			{steel_item, "", steel_item},
			{steel_item, "", steel_item},
		}
	})
minetest.register_craft({
	output = "steel:scrap 2",
	recipe = {{"steel:grate_soft"}}
})
]]--
