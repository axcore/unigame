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
minetest.register_node("cucina_vegana:sea_salad", {
	description = S("Sea Salad Bowl"),
	drawtype = "plantlike",
	tiles = {"cucina_vegana_sea_salad.png"},
	inventory_image = "cucina_vegana_sea_salad.png",
	wield_image = "cucina_vegana_sea_salad.png",
	on_use = minetest.item_eat(5, "cucina_vegana:bowl"),
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_glass_defaults(),
})
]]--
