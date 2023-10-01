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
minetest.register_node("darkage:glass", {
	description = "Clean Medieval Glass",
	drawtype = "glasslike",
	tiles = {"darkage_glass.png"},
	use_texture_alpha = "clip",
	paramtype = "light",
	sunlight_propagates = true,
	groups = {cracky = 3, oddly_breakable_by_hand = 3, not_cuttable=1},
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_craft({
	output = "darkage:glass 8",
	recipe = {
		{"default:glass", "default:steel_ingot", "default:glass"},
		{"default:steel_ingot", "default:glass", "default:steel_ingot"},
		{"default:glass", "default:steel_ingot", "default:glass"},
	}
})
]]--
