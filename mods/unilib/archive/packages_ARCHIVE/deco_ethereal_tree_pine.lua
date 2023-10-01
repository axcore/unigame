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
-- default large pine tree for lower elevation
add_schem({"ethereal:cold_dirt", "default:dirt_with_coniferous_litter"},
	0.025, {"coniferous_forest"}, 10, 40, ethereal.pinetree, ethereal.snowy)

-- small pine for higher elevation
add_schem({"default:dirt_with_snow"}, 0.025, {"taiga"}, 40, 140,
	ethereal.pinetree, ethereal.alpine)
]]--
