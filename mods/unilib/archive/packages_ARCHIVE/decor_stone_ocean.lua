---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xocean
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_stone_ocean = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xocean.add_mode

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("xocean:ocean_carved", {
	description = "Carved Ocean Stone",
	tiles = {"xocean_carved.png"},
	groups = {cracky=2},
})
minetest.register_craft({
	output = '"xocean:ocean_carved" 4',
	recipe = {
		{'xocean:ocean_stone', 'xocean:ocean_stone',},
		{'xocean:ocean_stone', 'xocean:ocean_stone',},
		},
})

minetest.register_node("xocean:ocean_circular", {
	description = "Circular Ocean Stone",
	tiles = {"xocean_circular.png"},
	groups = {cracky=2},
})
minetest.register_craft({
	output = '"xocean:ocean_circular" 4',
	recipe = {
		{'xocean:ocean_carved', 'xocean:ocean_carved',},
		{'xocean:ocean_carved', 'xocean:ocean_carved',},
		},
})

minetest.register_node("xocean:ocean_pillar", {
	description = "Ocean Pillar",
	tiles = {"xocean_pillar.png"},
	groups = {cracky=2},
})
minetest.register_craft({
	output = '"xocean:ocean_pillar" 4',
	recipe = {
		{'xocean:ocean_brick', 'xocean:ocean_brick',},
		{'xocean:ocean_brick', 'xocean:ocean_brick',},
		},
})
]]--

