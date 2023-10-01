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
minetest.register_node('earthbuild:acacia_wood_supported_rammed_earth', {
	description = 'Acacia Wood Supported Rammed Earth',
	drawtype = "normal",
	tiles = {
		"earthbuild_rammed_earth.png",
		"default_acacia_wood.png",
		"earthbuild_acacia_wood_supported_rammed_earth.png",
		"earthbuild_acacia_wood_supported_rammed_earth.png",
		"earthbuild_acacia_wood_supported_rammed_earth.png",
		"earthbuild_acacia_wood_supported_rammed_earth.png"
},
	paramtype = "light",
	groups = {crumbly = 1, cracky = 3, choppy = 2, flammable=1},
	sounds = default.node_sound_dirt_defaults(),
})
minetest.register_craft({
	output = 'earthbuild:acacia_wood_supported_rammed_earth 3',
	recipe = {
		{'earthbuild:rammed_earth', 'earthbuild:rammed_earth', 'earthbuild:rammed_earth'},
		{'default:acacia_wood', '', ''},
		{'', '', ''},
	}
})

minetest.register_node('earthbuild:supported_rammed_earth', {
	description = 'Supported Rammed Earth',
	drawtype = "normal",
	tiles = {
		"earthbuild_rammed_earth.png",
		"default_wood.png",
		"earthbuild_supported_rammed_earth.png",
		"earthbuild_supported_rammed_earth.png",
		"earthbuild_supported_rammed_earth.png",
		"earthbuild_supported_rammed_earth.png"
},
	paramtype = "light",
	groups = {crumbly = 1, cracky = 3, choppy = 2, flammable=1},
	sounds = default.node_sound_dirt_defaults(),
})
minetest.register_craft({
	output = 'earthbuild:supported_rammed_earth 3',
	recipe = {
		{'earthbuild:rammed_earth', 'earthbuild:rammed_earth', 'earthbuild:rammed_earth'},
		{'default:wood', '', ''},
		{'', '', ''},
	}
})

minetest.register_node('earthbuild:aspen_wood_supported_rammed_earth', {
	description = 'Aspen Wood Supported Rammed Earth',
	drawtype = "normal",
	tiles = {
		"earthbuild_rammed_earth.png",
		"default_aspen_wood.png",
		"earthbuild_aspen_wood_supported_rammed_earth.png",
		"earthbuild_aspen_wood_supported_rammed_earth.png",
		"earthbuild_aspen_wood_supported_rammed_earth.png",
		"earthbuild_aspen_wood_supported_rammed_earth.png"
},
	paramtype = "light",
	groups = {crumbly = 1, cracky = 3, choppy = 2, flammable=1},
	sounds = default.node_sound_dirt_defaults(),
})
minetest.register_craft({
	output = 'earthbuild:aspen_wood_supported_rammed_earth 3',
	recipe = {
		{'earthbuild:rammed_earth', 'earthbuild:rammed_earth', 'earthbuild:rammed_earth'},
		{'default:aspen_wood', '', ''},
		{'', '', ''},
	}
})

minetest.register_node('earthbuild:junglewood_supported_rammed_earth', {
	description = 'Jungle Wood Supported Rammed Earth',
	drawtype = "normal",
	tiles = {
		"earthbuild_rammed_earth.png",
		"default_junglewood.png",
		"earthbuild_junglewood_supported_rammed_earth.png",
		"earthbuild_junglewood_supported_rammed_earth.png",
		"earthbuild_junglewood_supported_rammed_earth.png",
		"earthbuild_junglewood_supported_rammed_earth.png"
},
	paramtype = "light",
	groups = {crumbly = 1, cracky = 3, choppy = 2, flammable=1},
	sounds = default.node_sound_dirt_defaults(),
})
minetest.register_craft({
	output = 'earthbuild:junglewood_supported_rammed_earth 3',
	recipe = {
		{'earthbuild:rammed_earth', 'earthbuild:rammed_earth', 'earthbuild:rammed_earth'},
		{'default:junglewood', '', ''},
		{'', '', ''},
	}
})

minetest.register_node('earthbuild:pine_wood_supported_rammed_earth', {
	description = 'Pine Wood Supported Rammed Earth',
	drawtype = "normal",
	tiles = {
		"earthbuild_rammed_earth.png",
		"default_pine_wood.png",
		"earthbuild_pine_wood_supported_rammed_earth.png",
		"earthbuild_pine_wood_supported_rammed_earth.png",
		"earthbuild_pine_wood_supported_rammed_earth.png",
		"earthbuild_pine_wood_supported_rammed_earth.png"
},
	paramtype = "light",
	groups = {crumbly = 1, cracky = 3, choppy = 2, flammable=1},
	sounds = default.node_sound_dirt_defaults(),
})
minetest.register_craft({
	output = 'earthbuild:pine_wood_supported_rammed_earth 3',
	recipe = {
		{'earthbuild:rammed_earth', 'earthbuild:rammed_earth', 'earthbuild:rammed_earth'},
		{'default:pine_wood', '', ''},
		{'', '', ''},
	}
})
]]--
