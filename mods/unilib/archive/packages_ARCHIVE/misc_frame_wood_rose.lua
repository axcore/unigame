---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr6
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("lib_materials:frame_wood_rose", {
	description = S("Frame - Wood Rose"),
	drawtype = "glasslike_framed",
	tiles = {"lib_materials_frame_wood_medieval_rose.png"},
	use_texture_alpha = true,
	paramtype = "light",
	sunlight_propagates = true,
	groups = {snappy = 2, cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
})
]]--
