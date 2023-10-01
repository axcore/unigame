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
