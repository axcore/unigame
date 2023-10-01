---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("ethereal:fern", {
	description = S("Fern"),
	drawtype = "plantlike",
	visual_scale = 1.4,
	tiles = {"ethereal_fern.png"},
	inventory_image = "ethereal_fern.png",
	wield_image = "ethereal_fern.png",
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = {
		max_items = 1,
		items = {
			{items = {"ethereal:fern_tubers"}, rarity = 6},
			{items = {"ethereal:fern"}}
		}
	},
	groups = {snappy = 3, flora = 1, attached_node = 1, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 0.67, 5 / 16}
	}
})
minetest.register_craftitem("ethereal:fern_tubers", {
	description = S("Fern Tubers"),
	inventory_image = "ethereal_fern_tubers.png",
	groups = {food_tuber = 1, flammable = 2},
	on_use = minetest.item_eat(1)
})
]]--
