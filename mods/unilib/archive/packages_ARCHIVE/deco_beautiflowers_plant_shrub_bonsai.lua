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
local function register_bonsai(name)

	minetest.register_decoration({
		name = "beautiflowers:"..name,
		deco_type = "simple",
		place_on = {"default:stone","default:cobble","default:mossycobble"},
		sidelen = 16,
		noise_params = {
			offset = -0.006,
			scale = 0.07,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66,
		},
		y_max = 30000,
		y_min = 30,
		decoration = "beautiflowers:"..name,
	})

end
]]--
