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
minetest.register_node("darkage:wood_frame", {
	description = "Wooden Frame",
	drawtype = "glasslike_framed",
	tiles = {"darkage_wood_frame.png"},
	inventory_image = "darkage_wood_frame.png",
	wield_image = "darkage_wood_frame.png",
	is_ground_content = false,
	paramtype = "light",
	sunlight_propagates = true,
	groups = {snappy=1, choppy=2, oddly_breakable_by_hand = 3, not_cuttable=1},
	sounds = default.node_sound_stone_defaults()
})
minetest.register_craft({
	output = "darkage:wood_frame",
	recipe = {
		{"group:stick",	"",					"group:stick"},
		{"",			"default:glass",	""},
		{"group:stick",	"",					"group:stick"},
	}
})
minetest.register_craft({
	type = "cooking",
	output = "default:glass",
	recipe = "darkage:wood_frame",
})
]]--
