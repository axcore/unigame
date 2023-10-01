---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    earthbuild
-- Code:    GPLv3
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node('earthbuild:wattle', {
	description = 'Wattle',
	drawtype = "nodebox",
	node_box = {
		type = "connected",
		fixed = {{-1/8, -1/2, -1/8, 1/8, 1/2, 1/8}},
		-- connect_bottom =
		connect_front = {{-1/8, -1/2, -1/2,  1/8, 1/2, -1/8}},
		connect_left = {{-1/2, -1/2, -1/8, -1/8, 1/2,  1/8}},
		connect_back = {{-1/8, -1/2,  1/8,  1/8, 1/2,  1/2}},
		connect_right = {{ 1/8, -1/2, -1/8,  1/2, 1/2,  1/8}},
	},
	connects_to = { "group:crumbly", "group:wood", "group:tree", "group:stone", 'earthbuild:wattle', 'earthbuild:wattle_loose',},
	paramtype = "light",
	tiles = {"earthbuild_wattle_top.png", "earthbuild_wattle_top.png","earthbuild_wattle.png", "earthbuild_wattle.png", "earthbuild_wattle.png", "earthbuild_wattle.png" },
	inventory_image = "earthbuild_wattle.png",
	wield_image = "earthbuild_wattle.png",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 1,},
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_craft({
	output = 'earthbuild:wattle 4',
	recipe = {
		{'', '', ''},
		{'', 'group:stick', ''},
		{'group:stick', 'group:stick', 'group:stick'},
	}
})
minetest.register_craft({
	output = 'earthbuild:wattle',
	recipe = {{'earthbuild:wattle_and_daub'}}
})
minetest.register_craft({
	output = 'default:stick',
	recipe = {
		{'earthbuild:wattle'}
	}
})
minetest.register_craft({
	output = 'earthbuild:wattle',
	recipe = {{'earthbuild:wattle_loose', 'earthbuild:wattle_loose'}}
})
minetest.register_craft({
	type = "fuel",
	recipe = "earthbuild:wattle",
	burntime = 3,
})

minetest.register_node('earthbuild:wattle_loose', {
	description = 'Loose Wattle',
	drawtype = "nodebox",
	node_box = {
		type = "connected",
		fixed = {{-1/8, -1/2, -1/8, 1/8, 1/2, 1/8}},
		-- connect_bottom =
		connect_front = {{-1/8, -1/2, -1/2,  1/8, 1/2, -1/8}},
		connect_left = {{-1/2, -1/2, -1/8, -1/8, 1/2,  1/8}},
		connect_back = {{-1/8, -1/2,  1/8,  1/8, 1/2,  1/2}},
		connect_right = {{ 1/8, -1/2, -1/8,  1/2, 1/2,  1/8}},
	},
	connects_to = { "group:crumbly", "group:wood", "group:tree", "group:stone", 'earthbuild:wattle', 'earthbuild:wattle_loose', 'earthbuild:thatch'},
	paramtype = "light",
	tiles = {"earthbuild_wattle_top.png", "earthbuild_wattle_top.png","earthbuild_wattle_loose.png", "earthbuild_wattle_loose.png", "earthbuild_wattle_loose.png", "earthbuild_wattle_loose.png" },
	inventory_image = "earthbuild_wattle_loose.png",
	wield_image = "earthbuild_wattle_loose.png",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 1,},
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_craft({
	output = 'earthbuild:wattle_loose 4',
	recipe = {{ 'earthbuild:wattle','earthbuild:wattle'}}
})
minetest.register_craft({
	type = "fuel",
	recipe = "earthbuild:wattle_loose",
	burntime = 1.5,
})

minetest.register_node('earthbuild:wattle_and_daub', {
	description = 'Wattle and Daub',
	drawtype = "nodebox",
	node_box = {
		type = "connected",
		fixed = {{-1/4, -1/2, -1/4, 1/4, 1/2, 1/4}},
		-- connect_bottom =
		connect_front = {{-1/4, -1/2, -1/2,  1/4, 1/2, -1/4}},
		connect_left = {{-1/2, -1/2, -1/4, -1/4, 1/2,  1/4}},
		connect_back = {{-1/4, -1/2,  1/4,  1/4, 1/2,  1/2}},
		connect_right = {{ 1/4, -1/2, -1/4,  1/2, 1/2,  1/4}},
	},
	connects_to = { "group:crumbly", "group:wood", "group:tree", "group:stone",'earthbuild:wattle', 'earthbuild:wattle_loose',},
	paramtype = "light",
	tiles = {"earthbuild_wattle_and_daub.png"},
	inventory_image = "earthbuild_wattle_and_daub.png",
	wield_image = "earthbuild_wattle_and_daub.png",
	groups = {crumbly = 2, cracky = 3, choppy = 2},
	sounds = default.node_sound_dirt_defaults(),
})
minetest.register_craft({
	output = 'earthbuild:wattle_and_daub 6',
	recipe = {
		{'earthbuild:wattle', 'earthbuild:wattle', 'earthbuild:wattle'},
		{'earthbuild:wattle', 'earthbuild:wattle', 'earthbuild:wattle'},
		{'', 'earthbuild:cob', ''},
	}
})
]]--
