---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/sequoia
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
if mg_name ~= "v6" and mg_name ~= "singlenode" then

	local name, place_on, biomes, offset, scale, schematic, place_offset_y, seed

	if minetest.get_modpath("redw") then
		place_on = {"redw:dirt", "redw:dirt_with_grass"}
		biomes = "redwood_forest"
	else
		place_on = "default:dirt_with_grass"
		biomes = "grassland"
	end

	for i = 1, 3 do
		if i == 1 then
			name = "sequoia:sequoia_small"
			schematic = "sequoia_01"
			offset = 0.008
			scale = 0.0004
			seed = 67
			place_offset_y = -1
		elseif i == 2 then
			name = "sequoia:sequoia_medium"
			schematic = "sequoia_02"
			offset = 0.008
			scale = 0.0004
			seed = 345
			place_offset_y = -1
		else
			name = "sequoia:sequoia_giant"
			schematic = "sequoia_03"
			offset = 0.0008
			scale = 0.00004
			seed = 23
			place_offset_y = -2
		end
		minetest.register_decoration({
			name = name,
			deco_type = "schematic",
			place_on = place_on,
			sidelen = 16,
			noise_params = {
				offset = offset,
				scale = scale,
				spread = {x = 250, y = 250, z = 250},
				seed = seed,
				octaves = 3,
				persist = 0.66
			},
			biomes = {biomes},
			y_min = 1,
			y_max = 80,
			schematic = modpath .. "/schematics/" .. schematic .. ".mts",
			flags = "place_center_x, place_center_z, force_placement",
			rotation = "random",
			place_offset_y = place_offset_y,
		})
	end
end
]]--
