---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("underch:dark_sichamine", {
	description = "Dark Sichamine",
	tiles = {"underch_dark_sichamine.png"},
	groups = {cracky = 3, stone = 1},
	is_ground_content = true,
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	type = "shapeless",
	output = "underch:dark_sichamine 3",
	recipe = {"underch:sichamine", "underch:sichamine", "underch:sichamine", "default:coal_lump"},
})

minetest.register_node("underch:weedy_sichamine", {
	description = "Weedy Sichamine",
	tiles = {"underch_weedy_sichamine.png"},
	groups = {cracky = 3, stone = 1},
	is_ground_content = true,
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	type = "shapeless",
	output = "underch:weedy_sichamine",
	recipe = {"underch:sichamine", "group:leaves"},
})
]]--
