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
farming.register_plant("farming:rice", {
	description = S("Rice grains"),
	paramtype2 = "meshoptions",
	inventory_image = "farming_rice_seed.png",
	steps = 8,
	place_param2 = 3
})
minetest.override_item("farming:rice", {
	description = S("Rice"),
	groups = {food_rice = 1, flammable = 4}
})

minetest.override_item("farming:rice_1", {drop = {}})
minetest.override_item("farming:rice_2", {drop = {}})
minetest.override_item("farming:rice_3", {drop = {}})

minetest.register_craft({
	type = "fuel",
	recipe = "farming:rice",
	burntime = 1
})
]]--
