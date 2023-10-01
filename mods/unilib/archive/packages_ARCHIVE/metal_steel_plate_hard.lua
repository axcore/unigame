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
minetest.register_node("steel:plate_hard", {
	description = "Hardened steel plate",
	tiles = {"steel_plate_hard.png"},
	sounds = sound_api.node_sound_stone_defaults(),
	groups = {cracky = 1, dig_stone = 1},
})
minetest.register_craft({
	type = "cooking",
	output = "steel:plate_hard",
	recipe = "steel:plate_soft",
})
minetest.register_craft({
	output = "steel:scrap 4",
	recipe = {{"steel:plate_hard"}}
})
]]--
