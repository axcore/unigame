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
minetest.register_node('earthbuild:strawbale', {
	description = 'Straw-bale Wall',
	drawtype = "normal",
	tiles = {"earthbuild_wattle_and_daub.png"},
	paramtype = "light",
	--drop = "default:dirt",
	groups = {crumbly = 1, snappy = 2, falling_node = 1},
	sounds = default.node_sound_dirt_defaults(),
})
minetest.register_craft({
	output = 'earthbuild:strawbale 6',
	recipe = {
		{'earthbuild:thatch', 'earthbuild:thatch', 'earthbuild:thatch'},
		{'earthbuild:thatch', 'earthbuild:thatch', 'earthbuild:thatch'},
		{'', 'earthbuild:cob', ''},
	}
})
minetest.register_craft({
	output = 'earthbuild:strawbale 6',
	recipe = {
		{'farming:straw', 'farming:straw', 'farming:straw'},
		{'farming:straw', 'farming:straw', 'farming:straw'},
		{'', 'earthbuild:cob', ''},
	}
})
]]--
