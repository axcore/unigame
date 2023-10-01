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
	["circle_stone_bricks"] = {
		description = S("Circle Stone Bricks"),
		groups = {stone = 1, cracky = 3},
		is_ground_content = false,
		sounds = sound_stone,
	},
}
minetest.register_craft({
	output = "moreblocks:circle_stone_bricks 5",
	recipe = {
		{"", "default:stone", ""},
		{"default:stone", "default:coal_lump", "default:stone"},
		{"", "default:stone", ""},
	}
})
]]--
