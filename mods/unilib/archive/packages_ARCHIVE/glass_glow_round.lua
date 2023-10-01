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
minetest.register_node("darkage:glow_glass_round", {
	description = "Medieval Round Glow Glass",
	drawtype = "glasslike",
	tiles = {"darkage_glass_round.png"},
	use_texture_alpha = "clip",
	paramtype = "light",
	sunlight_propagates = true,
	light_source = default.LIGHT_MAX-3,
	groups = {cracky = 3, oddly_breakable_by_hand = 3, not_cuttable=1},
	sounds = default.node_sound_glass_defaults(),
    inventory_image = minetest.inventorycube("darkage_glow_glass_round.png")
})
minetest.register_craft({
	output = "darkage:glow_glass_round 1",
    type = "shaped",
	recipe = {
		{"darkage:glass_round"},
        {"default:torch"}
	}
})
minetest.register_craft({
	output = "darkage:glass_round 1",
	recipe = {{"darkage:glow_glass_round"}}
})
]]--
