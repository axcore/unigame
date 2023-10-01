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
minetest.register_node("underch:coal_dust", {
	description = "Coal Dust",
	tiles = {"underch_coal_dust.png"},
	groups = {crumbly = 2, falling_node = 1, flammable = 1},
	is_ground_content = false,
	sounds = default.node_sound_sand_defaults(),
})
minetest.register_craft({
	type = "fuel",
	recipe = "underch:coal_dust",
	burntime = 40,
})
minetest.register_craft({
	output = "default:coalblock",
	recipe = {
		{"underch:coal_dust","underch:coal_dust","underch:coal_dust"},
		{"underch:coal_dust","underch:coal_dust","underch:coal_dust"},
		{"underch:coal_dust","underch:coal_dust","underch:coal_dust"},
	}
})
]]--
