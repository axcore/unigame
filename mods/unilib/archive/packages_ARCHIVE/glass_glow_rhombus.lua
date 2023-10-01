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
minetest.register_node("darkage:glow_glass", {
	description = "Medieval Glow Glass",
	drawtype = "glasslike",
	tiles = {"darkage_glass.png"},
	use_texture_alpha = "clip",
	paramtype = "light",
	sunlight_propagates = true,
	light_source = default.LIGHT_MAX-3,
	groups = {cracky = 3, oddly_breakable_by_hand = 3, not_cuttable=1},
	sounds = default.node_sound_glass_defaults(),
    inventory_image = minetest.inventorycube("darkage_glow_glass.png")
})
minetest.register_craft({
	output = "darkage:glow_glass 1",
    type = "shaped",
	recipe = {
		{"darkage:glass"},
		{"default:torch"}
	}
})
minetest.register_craft({
	output = "darkage:glass 1",
    type = "shaped",
	recipe = {{"darkage:glow_glass"}},
})
]]--
