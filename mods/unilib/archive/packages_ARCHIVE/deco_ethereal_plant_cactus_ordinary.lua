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
add_node({"default:sandstone"}, 0.0025, {"sandstone"}, 1, 100,
	{"default:cactus"}, 3, nil, nil, ethereal.sandstone)

add_node({"default:desert_sand"}, 0.005, {"desert"}, 1, 100,
	{"default:cactus"}, 4, nil, nil, ethereal.desert)

if ethereal.desert == 1 then
	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:desert_sand"},
		sidelen = 80,
		noise_params = {
			offset = -0.0005,
			scale = 0.0015,
			spread = {x = 200, y = 200, z = 200},
			seed = 230,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"desert"},
		y_min = 5,
		y_max = 31000,
		schematic = dpath .. "large_cactus.mts",
		flags = "place_center_x",
		rotation = "random",
	})
end
]]--
