---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_decoration({
	deco_type = "simple",
	place_on = {
		"default:dirt_with_rainforest_litter",
		"default:dirt_with_grass",
		"default:dirt_with_coniferous_litter",
	},
	sidelen = 16,
	fill_ratio = 0.01,
	biomes = {"rainforest", "coniferous_forest"},
	decoration = "moreplants:bigfern",
	height = 1,
})
]]--
