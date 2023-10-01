---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/birch
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local place_on
local biomes
local offset
local scale

if minetest.get_modpath("rainf") then
	place_on = "rainf:meadow"
	biomes = "rainf"
	offset = 0.01
	scale = 0.001
else
	place_on = "default:dirt_with_grass"
	biomes = "grassland"
	offset = 0.008
	scale = 0.001
end

minetest.register_decoration({
	name = "birch:birch_tree",
	deco_type = "schematic",
	place_on = {place_on},
	sidelen = 16,
	noise_params = {
		offset = offset,
		scale = scale,
		spread = {x = 255, y = 255, z = 255},
		seed = 32,
		octaves = 3,
		persist = 0.67
	},
	biomes = {biomes},
	y_min = 1,
	y_max = 80,
	schematic = birch.birchtree,
	flags = "place_center_x, place_center_z",
	place_offset_y = 1,
})
]]--
