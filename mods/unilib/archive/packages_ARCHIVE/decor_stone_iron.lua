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
	["iron_stone"] = {
		description = S("Iron Stone"),
		groups = {stone = 1, cracky = 3},
		is_ground_content = false,
		sounds = sound_stone,
	},
}
minetest.register_craft({
	output = "moreblocks:iron_stone",
	type = "shapeless",
	recipe = {"default:steel_ingot", "default:stone"},
})
minetest.register_craft({
	output = "default:stone",
	type = "shapeless",
	recipe = {"default:coal_lump", "moreblocks:iron_stone"},
})
]]--
