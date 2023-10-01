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
minetest.register_node("darkage:lamp", {
	description = "Lamp",
	tiles = { "darkage_lamp.png" },
	paramtype = "light",
	sunlight_propagates = true,
	light_source = default.LIGHT_MAX-1,
	groups = {snappy=2, cracky=3, oddly_breakable_by_hand=3, flammable=1 , not_cuttable=1},
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_craft({
	output = "darkage:lamp",
	recipe = {
		{"group:stick",	"",				 "group:stick"},
		{"",			"default:torch", ""},
		{"group:stick",	"",				 "group:stick"},
	}
})
]]--
