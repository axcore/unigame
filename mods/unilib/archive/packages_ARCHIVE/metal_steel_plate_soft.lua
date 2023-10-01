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
minetest.register_node("steel:plate_soft", {
	description = "Soft steel plate",
	tiles = {"steel_plate_soft.png"},
	sounds = sound_api.node_sound_stone_defaults(),
	groups = {cracky = 2, dig_stone = 1},
})
	minetest.register_craft({
		output = "steel:plate_soft 2",
		recipe = {
			{steel_item, steel_item},
			{steel_item, steel_item},
		}
	})
minetest.register_craft({
	output = "steel:scrap 4",
	recipe = {{"steel:plate_soft"}}
})
]]--
