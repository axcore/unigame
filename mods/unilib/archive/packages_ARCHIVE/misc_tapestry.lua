---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    castle/castle_tapestries
-- Code:    MIT
-- Media:   MIT/WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("castle_tapestries:tapestry", {
	drawtype = "mesh",
	mesh = "castle_tapestry.obj",
	description = S("Tapestry"),
	tiles = {"castle_tapestry.png"},
	inventory_image = "castle_tapestry_inv.png",
	groups = {oddly_breakable_by_hand=3,flammable=3, ud_param2_colorable = 1},
	sounds = default.node_sound_defaults(),
	paramtype = "light",
	paramtype2 = "colorwallmounted",
	palette = "unifieddyes_palette_colorwallmounted.png",
	selection_box = {
		type = "wallmounted",
		wall_side = {-0.5,-0.5,0.4375,0.5,1.5,0.5},
	},
	after_place_node = unifieddyes.fix_rotation_nsew,
	after_dig_node = unifieddyes.after_dig_node,
	on_rotate = unifieddyes.fix_after_screwdriver_nsew
})
minetest.register_craft({
	type = "shapeless",
	output = 'castle_tapestries:tapestry',
	recipe = {'wool:white', 'default:stick'},
})

minetest.register_node("castle_tapestries:tapestry_long", {
	drawtype = "mesh",
	mesh = "castle_tapestry_long.obj",
	description = S("Tapestry (Long)"),
	tiles = {"castle_tapestry.png"},
	inventory_image = "castle_tapestry_long_inv.png",
	groups = {oddly_breakable_by_hand=3,flammable=3, ud_param2_colorable = 1},
	sounds = default.node_sound_defaults(),
	paramtype = "light",
	paramtype2 = "colorwallmounted",
	palette = "unifieddyes_palette_colorwallmounted.png",
	selection_box = {
		type = "wallmounted",
		wall_side = {-0.5,-0.5,0.4375,0.5,2.5,0.5},
	},
	after_place_node = unifieddyes.fix_rotation_nsew,
	after_dig_node = unifieddyes.after_dig_node,
	on_rotate = unifieddyes.fix_after_screwdriver_nsew
})
minetest.register_craft({
	type = "shapeless",
	output = 'castle_tapestries:tapestry_long',
	recipe = {'wool:white', 'castle_tapestries:tapestry'},
})

minetest.register_node("castle_tapestries:tapestry_very_long", {
	drawtype = "mesh",
	mesh = "castle_tapestry_very_long.obj",
	description = S("Tapestry (Very Long)"),
	tiles = {"castle_tapestry.png"},
	inventory_image = "castle_tapestry_very_long_inv.png",
	groups = {oddly_breakable_by_hand=3,flammable=3, ud_param2_colorable = 1},
	sounds = default.node_sound_defaults(),
	paramtype = "light",
	paramtype2 = "colorwallmounted",
	palette = "unifieddyes_palette_colorwallmounted.png",
	selection_box = {
		type = "wallmounted",
		wall_side = {-0.5,-0.5,0.4375,0.5,3.5,0.5},
	},
	after_place_node = unifieddyes.fix_rotation_nsew,
	after_dig_node = unifieddyes.after_dig_node,
	on_rotate = unifieddyes.fix_after_screwdriver_nsew
})
minetest.register_craft({
	type = "shapeless",
	output = 'castle_tapestries:tapestry_very_long',
	recipe = {'wool:white', 'castle_tapestries:tapestry_long'},
})

minetest.register_node("castle_tapestries:tapestry_top", {
	drawtype = "nodebox",
	description = S("Tapestry Top"),
	tiles = {"default_wood.png"},
	sunlight_propagates = true,
	groups = {flammable=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_defaults(),
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.6,-0.5,0.375,0.6,-0.375,0.5},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.6,-0.5,0.375,0.6,-0.375,0.5},
		},
	},
})
minetest.register_craft({
	type = "shapeless",
	output = 'castle_tapestries:tapestry_top',
	recipe = {'default:stick'},
})
]]--
