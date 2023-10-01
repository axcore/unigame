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
minetest.register_node("darkage:iron_grille", {
	description = "Iron Grille",
	drawtype = "glasslike",
	tiles = {"darkage_iron_grille.png"},
	inventory_image = "darkage_iron_grille.png",
	wield_image = "darkage_iron_grille.png",
	is_ground_content = false,
	paramtype = "light",
	sunlight_propagates = true,
	groups = {cracky=3 , not_cuttable=1},
	sounds = default.node_sound_stone_defaults()
})
minetest.register_craft({
	output = "darkage:iron_grille 3",
	recipe = {
        {"",					"darkage:iron_bars",	""},
        {"darkage:iron_bars",	"",						"darkage:iron_bars"},
        {"",					"darkage:iron_bars",	""},
	}
})
]]--
