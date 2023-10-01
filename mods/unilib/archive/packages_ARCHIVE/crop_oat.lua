---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
farming.register_plant("farming:oat", {
	description = S("Oat seed"),
	paramtype2 = "meshoptions",
	inventory_image = "farming_oat_seed.png",
	steps = 8,
	place_param2 = 3
})
minetest.override_item("farming:oat", {
	description = S("Oats"),
	groups = {food_oats = 1, flammable = 4}
})
minetest.register_craft({
	output = "farming:flour",
	recipe = {
		{"farming:oat", "farming:oat", "farming:oat"},
		{"farming:oat", "farming:mortar_pestle", ""}
	},
	replacements = {{"group:food_mortar_pestle", "farming:mortar_pestle"}}
})

minetest.override_item("farming:oat_1", {drop = {}})
minetest.override_item("farming:oat_2", {drop = {}})
minetest.override_item("farming:oat_3", {drop = {}})

minetest.register_craft({
	type = "fuel",
	recipe = "farming:oat",
	burntime = 1
})
]]--
