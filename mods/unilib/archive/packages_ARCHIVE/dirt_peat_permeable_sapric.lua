---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pedology
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
pedology.register_permeable_set("turf_sapric", "sapric turf", "sapric turf cutting",
	2, 2, 240, 1.2, {1200, 1300, 1400}, 2, sound_turf_sapric, { [0] = { crumbly = 3, flammable = 1 }, { crumbly = 3 }, { crumbly = 3 } } )

minetest.register_craft({
	type = "fuel",
	recipe = "pedology:turf_sapric_0",
	burntime = 300,
})
minetest.register_craft({
	type = "fuel",
	recipe = "pedology:lump_turf_sapric_0",
	burntime = 30,
})
]]--
