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
minetest.register_craftitem("ethereal:strawberry", {
	description = S("Strawberry"),
	inventory_image = "ethereal_strawberry.png",
	wield_image = "ethereal_strawberry.png",
	groups = {food_strawberry = 1, food_berry = 1, flammable = 2},
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "ethereal:strawberry_1")
	end,
	on_use = minetest.item_eat(1)
})

local crop_def = {
	drawtype = "plantlike",
	tiles = {"ethereal_strawberry_1.png"},
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = "",
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5}
	},
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults()
}
--stage 1
minetest.register_node("ethereal:strawberry_1", table.copy(crop_def))
-- stage 2
crop_def.tiles = {"ethereal_strawberry_2.png"}
minetest.register_node("ethereal:strawberry_2", table.copy(crop_def))
-- stage 3
crop_def.tiles = {"ethereal_strawberry_3.png"}
minetest.register_node("ethereal:strawberry_3", table.copy(crop_def))
-- stage 4
crop_def.tiles = {"ethereal_strawberry_4.png"}
minetest.register_node("ethereal:strawberry_4", table.copy(crop_def))
-- stage 5
crop_def.tiles = {"ethereal_strawberry_5.png"}
minetest.register_node("ethereal:strawberry_5", table.copy(crop_def))
-- stage 6
crop_def.tiles = {"ethereal_strawberry_6.png"}
crop_def.drop = {
	items = {
		{items = {"ethereal:strawberry 1"},rarity = 2},
		{items = {"ethereal:strawberry 2"},rarity = 3}
	}
}
minetest.register_node("ethereal:strawberry_6", table.copy(crop_def))
-- stage 7
crop_def.tiles = {"ethereal_strawberry_7.png"}
crop_def.drop = {
	items = {
		{items = {"ethereal:strawberry 1"},rarity = 1},
		{items = {"ethereal:strawberry 2"},rarity = 3}
	}
}
minetest.register_node("ethereal:strawberry_7", table.copy(crop_def))
-- stage 8
crop_def.tiles = {"ethereal_strawberry_8.png"}
crop_def.groups.growing = nil
crop_def.drop = {
	items = {
		{items = {"ethereal:strawberry 2"},rarity = 1},
		{items = {"ethereal:strawberry 3"},rarity = 3}
	}
}
minetest.register_node("ethereal:strawberry_8", table.copy(crop_def))
]]--
