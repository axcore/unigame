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
farming.register_plant("farming:rye", {
	description = S("Rye seed"),
	paramtype2 = "meshoptions",
	inventory_image = "farming_rye_seed.png",
	steps = 8,
	place_param2 = 3
})
minetest.override_item("farming:rye", {
	description = S("Rye"),
	groups = {food_rye = 1, flammable = 4}
})
minetest.register_craft({
	output = "farming:flour",
	recipe = {
		{"farming:rye", "farming:rye", "farming:rye"},
		{"farming:rye", "farming:mortar_pestle", ""}
	},
	replacements = {{"group:food_mortar_pestle", "farming:mortar_pestle"}}
})

minetest.override_item("farming:rye_1", {drop = {}})
minetest.override_item("farming:rye_2", {drop = {}})
minetest.override_item("farming:rye_3", {drop = {}})

minetest.register_craft({
	type = "fuel",
	recipe = "farming:rye",
	burntime = 1
})
]]--
