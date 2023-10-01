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
minetest.register_node("underch:goldstone", {
	description = "Goldstone",
	tiles = {"underch_goldstone.png"},
	groups = {cracky = 3, stone = 1},
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = "underch:goldstone 8",
	recipe = {
		{"group:stone","group:stone","group:stone"},
		{"group:stone","default:gold_ingot","group:stone"},
		{"group:stone","group:stone","group:stone"},
	}
})
]]--
