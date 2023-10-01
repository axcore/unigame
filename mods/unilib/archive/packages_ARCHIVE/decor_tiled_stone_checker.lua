---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreblocks
-- Code:    zlib
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local nodes = {
	["checker_stone_tile"] = {
		description = S("Checker Stone Tile"),
		groups = {stone = 1, cracky = 3},
		is_ground_content = false,
		sounds = sound_stone,
	},
}
minetest.register_craft({
	output = "moreblocks:checker_stone_tile",
	recipe = {
		{"moreblocks:split_stone_tile"},
	}
})
-- When approaching the below craft, loop back to cobblestone, which can then be used to craft stone tiles again
minetest.register_craft({
	output = "default:cobble",
	recipe = {
		{"moreblocks:checker_stone_tile"},
	}
})
]]--
