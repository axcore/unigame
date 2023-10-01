---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
beautiflowers.flowers ={
    {"pasto_1","dark_green", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}},
    {"pasto_2","dark_green", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}},
    {"pasto_3","dark_green", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}},
    {"pasto_4","dark_green", {-0.375, -0.5, -0.375, 0.375, 0.375, 0.375}},
    {"pasto_5","dark_green", {-0.375, -0.5, -0.375, 0.375, 0.375, 0.375}},
    {"pasto_6","dark_green", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}},
    {"pasto_7","dark_green", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}},
    {"pasto_8","dark_green", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}},
    {"pasto_9","dark_green", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}},
    {"pasto_10","dark_green",{-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}},
}

local function register_pasto(name)

	minetest.register_decoration({
		name = "beautiflowers:"..name,
		deco_type = "simple",
		place_on = {"default:dirt_with_grass","default:dirt"},
		sidelen = 16,
		noise_params = {
			offset = -0.03,
			scale = 0.07,
			spread = {x = 100, y = 100, z = 100},
			seed = 1602,
			octaves = 3,
			persist = 1,
		},
		y_max = 30000,
		y_min = 1,
		decoration = "beautiflowers:"..name,
        spawn_by = "default:dirt_with_grass"
	})

end
]]--
