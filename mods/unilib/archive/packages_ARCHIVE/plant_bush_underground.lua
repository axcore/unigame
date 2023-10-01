---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("underch:underground_bush", {
	description = "Underground Bush",
	drawtype = "allfaces",
	waving = 1,
	tiles = {"underch_underground_bush.png"},
	special_tiles = {"underch_underground_bush.png"},
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_craft({
	type = "fuel",
	recipe = "underch:underground_bush",
	burntime = 5,
})
minetest.register_craft({
	type = "shapeless",
	output = "default:stick 2",
	recipe = {"underch:underground_bush"},
})
]]--
