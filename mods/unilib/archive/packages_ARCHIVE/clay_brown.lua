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
minetest.register_node("underch:clay", {
	description = "Brown Clay",
	tiles = {"underch_clay.png"},
	groups = {crumbly = 3},
	drop = 'underch:clay_lump 4',
	sounds = default.node_sound_dirt_defaults(),
})
minetest.register_craft({
	output = 'underch:clay',
	recipe = {
		{'underch:clay_lump', 'underch:clay_lump'},
		{'underch:clay_lump', 'underch:clay_lump'},
	}
})

minetest.register_craftitem("underch:clay_lump", {
	description = "Brown Clay Lump",
	inventory_image = "underch_clay_lump.png",
})
minetest.register_craft({
	output = 'underch:clay_lump 4',
	recipe = {
		{'underch:clay'},
	}
})
minetest.register_craft({
	type = "cooking",
	output = "default:clay_brick",
	recipe = "underch:clay_lump",
})
]]--
