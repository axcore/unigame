---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/hollytree
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
if mg_name ~= "v6" and mg_name ~= "singlenode" then

	local place_on
	local biomes
	local offset
	local scale

	if minetest.get_modpath("rainf") then
		place_on = "rainf:meadow"
		biomes = "rainf"
		offset = 0.0008
		scale = 0.00005
	else
		place_on = "default:dirt_with_grass"
		biomes = "grassland"
		offset = 0.00008
		scale = 0.00005
	end

	minetest.register_decoration({
		name = "hollytree:holly_tree",
		deco_type = "schematic",
		place_on = {place_on},
		sidelen = 16,
		noise_params = {
			offset = offset,
			scale = scale,
			spread = {x = 250, y = 250, z = 250},
			seed = 789,
			octaves = 3,
			persist = 0.66
		},
		biomes = {biomes},
		y_min = 1,
		y_max = 32,
		schematic = modpath.."/schematics/hollytree.mts",
		flags = "place_center_x, place_center_z, force_placement",
		rotation = "random",
	})
end
]]--
