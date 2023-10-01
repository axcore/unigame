---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xocean
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("xocean:ocean_stone", {
	description = "Ocean Stone",
	tiles = {"xocean_stone.png"},
	groups = {cracky=3},
	drop= "xocean:ocean_cobble",
})
minetest.register_craft({
	type = "cooking",
	output = "xocean:ocean_stone",
	recipe = "xocean:ocean_cobble",
})

minetest.register_node("xocean:ocean_brick", {
	description = "Ocean Brick",
	tiles = {"xocean_brick.png"},
	groups = {cracky=2},
})
minetest.register_craft({
	output = '"xocean:ocean_brick" 4',
	recipe = {
		{'xocean:ocean_cobble', 'xocean:ocean_cobble',},
		{'xocean:ocean_cobble', 'xocean:ocean_cobble',},
		},
})

minetest.register_node("xocean:ocean_cobble", {
	description = "Ocean Cobblestone",
	tiles = {"xocean_cobble.png"},
	groups = {cracky=3},
})
]]--
