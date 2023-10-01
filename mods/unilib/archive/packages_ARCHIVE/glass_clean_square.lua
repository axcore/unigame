---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("darkage:glass_square", {
	description = "Square Glass",
	drawtype = "glasslike",
	tiles = { "darkage_glass_square.png" },
	paramtype = "light",
	use_texture_alpha = "clip",
	sunlight_propagates = true,
	sounds = default.node_sound_glass_defaults(),
	groups = {cracky=3,oddly_breakable_by_hand=3, not_cuttable=1},
})
minetest.register_craft({
	output = "darkage:glass_square 8",
	recipe = {
		{"default:glass",		"default:steel_ingot", "default:glass"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"default:glass",		"default:steel_ingot", "default:glass"},
	}
})
]]--
