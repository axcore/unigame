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
minetest.register_node("darkage:wood_grille", {
	description = "Wooden Grille",
	drawtype = "glasslike",
	tiles = {"darkage_wood_grille.png"},
	inventory_image = "darkage_wood_grille.png",
	wield_image = "darkage_wood_grille.png",
	is_ground_content = false,
	paramtype = "light",
	sunlight_propagates = true,
	groups = {snappy=1, choppy=2, not_cuttable=1},
	sounds = default.node_sound_stone_defaults()
})
minetest.register_craft({
	output = "darkage:wood_grille 3",
	recipe = {
		{"",					"darkage:wood_bars", ""},
		{"darkage:wood_bars",	"",					 "darkage:wood_bars"},
		{"",					"darkage:wood_bars", ""},
	}
})
]]--
