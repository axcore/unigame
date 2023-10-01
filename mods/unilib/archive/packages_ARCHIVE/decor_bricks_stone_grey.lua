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
	["grey_bricks"] = {
		description = S("Stone Bricks"),
		paramtype2 = "facedir",
		place_param2 = 0,
		groups = {cracky = 3},
		is_ground_content = false,
		sounds = sound_stone,
	},
}
minetest.register_craft({
	output = "moreblocks:grey_bricks 2",
	type = "shapeless",
	recipe =  {"default:stone", "default:brick"},
})
minetest.register_craft({
	output = "moreblocks:grey_bricks 2",
	type = "shapeless",
	recipe =  {"default:stonebrick", "default:brick"},
})
]]--
