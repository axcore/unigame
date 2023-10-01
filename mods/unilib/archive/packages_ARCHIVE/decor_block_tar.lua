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
	["tar"] = {
		description = S("Tar"),
		groups = {cracky=2, tar_block=1},
		is_ground_content = false,
		sounds = sound_stone,
	},
}
minetest.register_craft({
	type = "cooking", output = "moreblocks:tar", recipe = "default:pine_tree",
})
]]--
