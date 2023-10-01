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
minetest.register_node("pedology:snow_packing", {
	description = S("packing snow"),
	tiles = { "pedology_snow_packing.png" },
	sounds = { footstep = { name = "pedology_snow_footstep", gain = 1 } },
	is_ground_content = true,
	groups = { crumbly = 3, level = 3, melts = 1 },
	drop = "pedology:lump_snow 3",
	freezemelt = "pedology:water_fresh_source",
})
]]--
