---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("cucina_vegana:plate", {
	description = S("Plate"),
	drawtype = "plantlike",
	tiles = {"cucina_vegana_plate.png"},
	inventory_image = "cucina_vegana_plate.png",
	wield_image = "cucina_vegana_plate.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {dig_immediate = 3, attached_node = 1, food_plate=1},
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_craft({
	output = "cucina_vegana:plate 2",
	recipe = {	{"default:clay_lump", "", "default:clay_lump"},
				{"default:clay_lump", "default:cobble", "default:clay_lump"}
			}
})
]]--
