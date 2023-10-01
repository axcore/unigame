---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    maptools
-- Code:    zlib
-- Media:   zlib
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
register_node("maptools:playerclip", {
	description = S("Player Clip"),t
	inventory_image = "default_steel_block.png^dye_green.png",
	drawtype = "airlike",
	paramtype = "light",
	pointable = false,
	sunlight_propagates = true,
})

register_node("maptools:fullclip", {
	description = S("Full Clip"),
	inventory_image = "default_steel_block.png^dye_blue.png",
	drawtype = "airlike",
	paramtype = "light",
	sunlight_propagates = true,
})

register_node("maptools:fullclip_face", {
	description = S("Full Clip Face"),
	inventory_image = "default_steel_block.png^dye_white.png",
	drawtype = "nodebox",
	tiles = {"invisible.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4999, 0.5},
	},
	groups = {
		fall_damage_add_percent = -100,
	},
})

register_node("maptools:fake_walkable", {
	description = S("Player Clip"),
	inventory_image = "default_steel_block.png^dye_green.png",
	drawtype = "airlike",
	paramtype = "light",
	pointable = false,
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{0, 0, 0, 0, 0, 0},
		},
	},
})

register_node("maptools:fake_walkable_pointable", {
	description = S("Player Clip"),
	inventory_image = "default_steel_block.png^dye_green.png",
	drawtype = "airlike",
	paramtype = "light",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{0, 0, 0, 0, 0, 0},
		},
	},
})

register_node("maptools:nobuild", {
	description = S("Build Prevention"),
	inventory_image = "default_steel_block.png^default_flint.png",
	drawtype = "airlike",
	walkable = false,
	pointable = false,
	paramtype = "light",
	sunlight_propagates = true,
})

register_node("maptools:nointeract", {
	description = S("Interact Prevention"),
	inventory_image = "default_steel_block.png^default_bush_stem.png",
	drawtype = "airlike",
	walkable = false,
	paramtype = "light",
	sunlight_propagates = true,
})
]]--
