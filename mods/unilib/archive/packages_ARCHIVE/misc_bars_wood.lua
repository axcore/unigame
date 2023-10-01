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
minetest.register_node("darkage:wood_bars", {
	description = "Wooden Bars",
	drawtype = "glasslike",
	tiles = {"darkage_wood_bars.png"},
	inventory_image = "darkage_wood_bars.png",
	wield_image = "darkage_wood_bars.png",
	is_ground_content = false,
	paramtype = "light",
	sunlight_propagates = true,
	groups = {snappy=1, choppy=2, not_cuttable=1},
	sounds = default.node_sound_stone_defaults()
})
minetest.register_craft({
	output = "darkage:wood_bars 2",
	recipe = {
    {"group:stick", "", "group:stick"},
    {"group:stick", "", "group:stick"},
    {"group:stick", "", "group:stick"},
	}
})
]]--
