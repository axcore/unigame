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
minetest.register_node('earthbuild:whitewashed_strawbale', {
	description = 'Whitewashed Straw-bale Wall',
	drawtype = "normal",
	tiles = {"earthbuild_whitewashed_earth.png"},
	paramtype = "light",
	--drop = "default:dirt",
	groups = {crumbly = 1, snappy = 1, falling_node = 1},
	sounds = default.node_sound_dirt_defaults(),
})
minetest.register_craft({
	output = 'earthbuild:whitewashed_strawbale',
	recipe = {
		{'earthbuild:strawbale', 'earthbuild:whitewash'},
	}
})
]]--
