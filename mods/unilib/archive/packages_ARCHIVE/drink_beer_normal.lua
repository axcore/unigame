---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("bbq:beer", {
	description = ("Beer"),
	inventory_image = "bbq_beer.png",
	wield_image = "bbq_beer.png",
	drawtype = "plantlike",
	sunlight_propagates = true,
	tiles = {
		"bbq_beer_top.png", "bbq_beer_top.png^[transformFy",
		"bbq_beer.png", "bbq_beer.png",
		"bbq_beer.png", "bbq_beer.png^[transformFx",
	},
	groups = {dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_glass_defaults(),
	paramtype = "light",
	paramtype2 = "facedir",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
				{-0.18, -0.5, -0.18, 0.18, 0.3, 0.18},
				{-0.3, -0.25, -0.06, -0.18, 0.18, 0.06},

			},
		},


	on_use = minetest.item_eat(6),
})
minetest.register_craft({
	output = "bbq:beer",
	type = "shapeless",
	recipe = {"bucket:bucket_water", "bbq:yeast", "farming:wheat", "group:food_sugar", "vessels:drinking_glass"},
	replacements = {{"bucket:bucket_water","bucket:bucket_empty"}},
})
]]--
