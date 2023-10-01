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
minetest.register_node('earthbuild:whitewashed_wattle_and_daub', {
	description = 'Whitewashed Wattle and Daub',
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
	connects_to = { "group:crumbly", "group:wood", "group:tree", "group:stone", 'earthbuild:wattle', 'earthbuild:wattle_loose'},
	paramtype = "light",
	tiles = {"earthbuild_whitewashed_earth.png"},
	inventory_image = "earthbuild_whitewashed_earth.png",
	wield_image = "earthbuild_whitewashed_earth.png",
	groups = {crumbly = 1, cracky = 2, choppy = 2},
	sounds = default.node_sound_dirt_defaults(),
})
minetest.register_craft({
	output = 'earthbuild:whitewashed_wattle_and_daub',
	recipe = {
		{'earthbuild:wattle_and_daub', 'earthbuild:whitewash'},
	}
})
minetest.register_craft({
	output = 'earthbuild:wattle',
	recipe = {{'earthbuild:whitewashed_wattle_and_daub'}}
})
]]--
