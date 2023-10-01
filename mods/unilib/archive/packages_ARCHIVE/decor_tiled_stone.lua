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
	["stone_tile"] = {
		description = S("Stone Tile"),
		groups = {stone = 1, cracky = 3},
		is_ground_content = false,
		sounds = sound_stone,
	},
}
minetest.register_craft({
	output = "moreblocks:stone_tile 9",
	recipe = {
		{"default:cobble", "default:cobble", "default:cobble"},
		{"default:cobble", "default:stone", "default:cobble"},
		{"default:cobble", "default:cobble", "default:cobble"},
	}
})
]]--
