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
pedology.register_permeable_set("turf_hemic", "hemic turf", "hemic turf cutting",
	2, 2, 180, 1.225, {1100, 1200, 1300}, 3, sound_turf_hemic, { [0] = { crumbly = 3, flammable = 1 }, { crumbly = 3 }, { crumbly = 3 } }  )

minetest.register_craft({
	type = "fuel",
	recipe = "pedology:turf_hemic_0",
	burntime = 200,
})
minetest.register_craft({
	type = "fuel",
	recipe = "pedology:lump_turf_hemic_0",
	burntime = 20,
})
]]--
