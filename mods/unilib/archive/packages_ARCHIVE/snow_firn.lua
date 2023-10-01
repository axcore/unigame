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
minetest.register_node("pedology:snow_firn", {
	description = S("firn"),
	tiles = { "pedology_snow_firn.png" },
	sounds = { footstep = { name = "pedology_ice_white_footstep", gain = 0.7 } },
	is_ground_content = true,
	groups = { crumbly = 2, cracky = 2, level = 4, melts = 1 },
	drop = "pedology:lump_snow 4",
	freezemelt = "pedology:water_fresh_source",
})
]]--
