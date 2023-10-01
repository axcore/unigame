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
minetest.register_node("pedology:snow_soft", {
	description = S("soft snow"),
	tiles = { "pedology_snow_soft.png" },
	sounds = { footstep = { name = "pedology_snow_soft_footstep", gain = 1 } },
	is_ground_content = true,
	groups = { crumbly = 2, level = 2, melts = 1, falling_node = 1 },
	drop = "pedology:lump_snow 1",
	freezemelt = "pedology:water_fresh_source",
})
]]--
