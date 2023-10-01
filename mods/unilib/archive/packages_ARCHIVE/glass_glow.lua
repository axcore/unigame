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
	["glow_glass"] = {
		description = S("Glow Glass"),
		drawtype = "glasslike_framed_optional",
		tiles = {"default_glass.png^[colorize:#E9CD61", "default_glass_detail.png^[colorize:#E9CD61"},
		use_texture_alpha = "clip",
		paramtype = "light",
		sunlight_propagates = true,
		is_ground_content = false,
		light_source = 11,
		groups = {cracky = 3, oddly_breakable_by_hand = 3},
		sounds = sound_glass,
	},
}
minetest.register_craft({
	output = "moreblocks:glow_glass",
	type = "shapeless",
	recipe = {"default:torch", "default:glass"},
})
]]--
