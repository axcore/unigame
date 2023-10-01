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
local function register_flower(name)
    local fill = (FLOWERS_AMOUNT/16000)
	minetest.register_decoration({
		name = "beautiflowers:"..name,
		deco_type = "simple",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
        fill_ratio = fill,
		y_max = MAX_HEIGHT,
		y_min = 1,
		decoration = "beautiflowers:"..name,
	})
end
]]--
