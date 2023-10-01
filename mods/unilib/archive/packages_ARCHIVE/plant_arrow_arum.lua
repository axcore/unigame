---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    valleys_c
-- Code:    GPL 3.0/BSD/WTFPL
-- Media:   GPL 3.0/BSD/WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
valc.plantlist = {
	{name="arrow_arum",
	 desc="Arrow Arum",
	 water=true,
	 wave=true,
	 group="plantnodye",
	},
}

do
	-- Water Plant: Arrow Arum
	local arrow_def_sand = {
		fill_ratio = 0.05,
		place_on = {"group:sand"},
		decoration = {"valleys_c:arrow_arum_water_sand",},
		--biomes = {"sandstone_grassland", "stone_grassland", "coniferous_forest", "deciduous_forest", "desert", "savanna", "rainforest", "rainforest_swamp", "desertstone_grassland", },
		biomes = {"sandstone_grassland", "stone_grassland", "coniferous_forest", "deciduous_forest", "desert", "savanna", "rainforest", "rainforest_swamp","sandstone_grassland_ocean", "stone_grassland_ocean", "coniferous_forest_ocean", "deciduous_forest_ocean", "desert_ocean", "savanna_ocean", "desertstone_grassland", },
		y_max = 60,
	}
	local arrow_def_soil = table.copy(arrow_def_sand)
	arrow_def_soil.place_on = {"group:soil"}
	arrow_def_soil.decoration = {"valleys_c:arrow_arum_water_soil",}

	valc.register_water_plant(arrow_def_sand)
	valc.register_water_plant(arrow_def_soil)
end
]]--
