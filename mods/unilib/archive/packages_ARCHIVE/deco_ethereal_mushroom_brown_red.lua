---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local list = {
	{"junglee", {"ethereal:jungle_dirt", "default:dirt_with_rainforest_litter"}, ethereal.junglee},
	{"deciduous_forest", {"default:dirt_with_grass"}, ethereal.grassy},
	{"grassytwo", {"default:dirt_with_grass"}, ethereal.grassytwo},
	{"prairie", {"ethereal:prairie_dirt"}, ethereal.prairie},
	{"mushroom", {"ethereal:mushroom_dirt"}, ethereal.mushroom},
	{"swamp", {"default:dirt_with_grass"}, ethereal.swamp}
}

-- wild red and brown mushrooms
for _, row in pairs(list) do

	if row[3] == 1 then

		minetest.register_decoration({
			deco_type = "simple",
			place_on = row[2],
			sidelen = 16,
			noise_params = {
				offset = 0,
				scale = 0.009,
				spread = {x = 200, y = 200, z = 200},
				seed = 2,
				octaves = 3,
				persist = 0.66
			},
			biomes = {row[1]},
			y_min = 1,
			y_max = 120,
			decoration = {"flowers:mushroom_brown", "flowers:mushroom_red"}
		})
	end
end
]]--
