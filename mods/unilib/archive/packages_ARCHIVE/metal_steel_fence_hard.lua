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
minetest.register_node("steel:grate_hard", {
	description = "Hardened Steel Grate",
	drawtype = "fencelike",
	tiles = {"steel_grate_hard.png"},
	inventory_image = "steel_grate_hard_inventory.png",
	wield_image = "steel_grate_hard_inventory.png",
	paramtype = "light",
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	sounds = sound_api.node_sound_wood_defaults(),
	groups = {cracky = 1, choppy = 1, dig_stone = 1},
})
minetest.register_craft({
	type = "cooking",
	output = "steel:grate_hard",
	recipe = "steel:grate_soft",
})
minetest.register_craft({
	output = "steel:scrap 2",
	recipe = {{"steel:grate_hard"}}
})
]]--
