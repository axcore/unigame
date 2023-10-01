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
minetest.register_node('earthbuild:acacia_wood_supported_cob', {
	description = 'Acacia Wood Supported Cob',
	drawtype = "normal",
	tiles = {
		"earthbuild_cob.png",
		"default_acacia_wood.png",
		"earthbuild_acacia_wood_supported_cob.png",
		"earthbuild_acacia_wood_supported_cob.png",
		"earthbuild_acacia_wood_supported_cob.png",
		"earthbuild_acacia_wood_supported_cob.png"
},
	paramtype = "light",
	groups = {crumbly = 2, cracky = 3, choppy = 2, flammable=1},
	sounds = default.node_sound_dirt_defaults(),
})
minetest.register_craft({
	output = 'earthbuild:acacia_wood_supported_cob 3',
	recipe = {
		{'earthbuild:cob', 'earthbuild:cob', 'earthbuild:cob'},
		{'default:acacia_wood', '', ''},
		{'', '', ''},
	}
})

minetest.register_node('earthbuild:supported_cob', {
	description = 'Supported Cob',
	drawtype = "normal",
	tiles = {
		"earthbuild_cob.png",
		"default_wood.png",
		"earthbuild_supported_cob.png",
		"earthbuild_supported_cob.png",
		"earthbuild_supported_cob.png",
		"earthbuild_supported_cob.png"
},
	paramtype = "light",
	groups = {crumbly = 2, cracky = 3, choppy = 2, flammable=1},
	sounds = default.node_sound_dirt_defaults(),
})
minetest.register_craft({
	output = 'earthbuild:supported_cob 3',
	recipe = {
		{'earthbuild:cob', 'earthbuild:cob', 'earthbuild:cob'},
		{'default:wood', '', ''},
		{'', '', ''},
	}
})

minetest.register_node('earthbuild:aspen_wood_supported_cob', {
	description = 'Aspen Wood Supported Cob',
	drawtype = "normal",
	tiles = {
		"earthbuild_cob.png",
		"default_aspen_wood.png",
		"earthbuild_aspen_wood_supported_cob.png",
		"earthbuild_aspen_wood_supported_cob.png",
		"earthbuild_aspen_wood_supported_cob.png",
		"earthbuild_aspen_wood_supported_cob.png"
},
	paramtype = "light",
	groups = {crumbly = 2, cracky = 3, choppy = 2, flammable=1},
	sounds = default.node_sound_dirt_defaults(),
})
minetest.register_craft({
	output = 'earthbuild:aspen_wood_supported_cob 3',
	recipe = {
		{'earthbuild:cob', 'earthbuild:cob', 'earthbuild:cob'},
		{'default:aspen_wood', '', ''},
		{'', '', ''},
	}
})

minetest.register_node('earthbuild:junglewood_supported_cob', {
	description = 'Jungle Wood Supported Cob',
	drawtype = "normal",
	tiles = {
		"earthbuild_cob.png",
		"default_junglewood.png",
		"earthbuild_junglewood_supported_cob.png",
		"earthbuild_junglewood_supported_cob.png",
		"earthbuild_junglewood_supported_cob.png",
		"earthbuild_junglewood_supported_cob.png"
},
	paramtype = "light",
	groups = {crumbly = 2, cracky = 3, choppy = 2, flammable=1},
	sounds = default.node_sound_dirt_defaults(),
})
minetest.register_craft({
	output = 'earthbuild:junglewood_supported_cob 3',
	recipe = {
		{'earthbuild:cob', 'earthbuild:cob', 'earthbuild:cob'},
		{'default:junglewood', '', ''},
		{'', '', ''},
	}
})

minetest.register_node('earthbuild:pine_wood_supported_cob', {
	description = 'Pine Wood Supported Cob',
	drawtype = "normal",
	tiles = {
		"earthbuild_cob.png",
		"default_pine_wood.png",
		"earthbuild_pine_wood_supported_cob.png",
		"earthbuild_pine_wood_supported_cob.png",
		"earthbuild_pine_wood_supported_cob.png",
		"earthbuild_pine_wood_supported_cob.png"
},
	paramtype = "light",
	groups = {crumbly = 2, cracky = 3, choppy = 2, flammable=1},
	sounds = default.node_sound_dirt_defaults(),
})
minetest.register_craft({
	output = 'earthbuild:pine_wood_supported_cob 3',
	recipe = {
		{'earthbuild:cob', 'earthbuild:cob', 'earthbuild:cob'},
		{'default:pine_wood', '', ''},
		{'', '', ''},
	}
})
]]--
