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
	["iron_glass"] = {
		description = S("Iron Glass"),
		drawtype = "glasslike_framed_optional",
		tiles = {"default_glass.png^[colorize:#DEDEDE", "default_glass_detail.png^[colorize:#DEDEDE"},
		use_texture_alpha = "clip",
		paramtype = "light",
		sunlight_propagates = true,
		is_ground_content = false,
		groups = {cracky = 3, oddly_breakable_by_hand = 3},
		sounds = sound_glass,
	},
}
minetest.register_craft({
	output = "moreblocks:iron_glass",
	type = "shapeless",
	recipe = {"default:steel_ingot", "default:glass"},
})
minetest.register_craft({
	output = "default:glass",
	type = "shapeless",
	recipe = {"default:coal_lump", "moreblocks:iron_glass"},
})
]]--
