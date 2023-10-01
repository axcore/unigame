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
	["super_glow_glass"] = {
		description = S("Super Glow Glass"),
		drawtype = "glasslike_framed_optional",
		tiles = {"default_glass.png^[colorize:#FFFF78", "default_glass_detail.png^[colorize:#FFFF78"},
		use_texture_alpha = "clip",
		paramtype = "light",
		sunlight_propagates = true,
		is_ground_content = false,
		light_source = default.LIGHT_MAX,
		groups = {cracky = 3, oddly_breakable_by_hand = 3},
		sounds = sound_glass,
	},
}
minetest.register_craft({
	output = "moreblocks:super_glow_glass",
	type = "shapeless",
	recipe = {"default:torch", "default:torch", "default:glass"},
})
minetest.register_craft({
	output = "moreblocks:super_glow_glass",
	type = "shapeless",
	recipe = {"default:torch", "moreblocks:glow_glass"},
})
]]--
