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
pedology.register_permeable_set("turf_fibric", "fibric turf", "fibric turf cutting",
	2, 2, 120, 1.25, {1000, 1100, 1200}, 4, sound_turf_fibric, { [0] = { crumbly = 3, flammable = 1 }, { crumbly = 3 }, {crumbly = 3} } )

minetest.register_craft({
	type = "fuel",
	recipe = "pedology:turf_fibric_0",
	burntime = 100,
})
minetest.register_craft({
	type = "fuel",
	recipe = "pedology:lump_turf_fibric_0",
	burntime = 10,
})
]]--
