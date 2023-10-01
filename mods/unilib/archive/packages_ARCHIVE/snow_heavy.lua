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
minetest.register_node("pedology:snow", {
	description = S("snow"),
	tiles = { "pedology_snow.png" },
	sounds = { footstep = { name = "pedology_snow_footstep", gain = 0.9 } },
	is_ground_content = true,
	groups = { crumbly = 3, level = 3, melts = 1, falling_node = 1 },
	drop = "pedology:lump_snow 2",
	freezemelt = "pedology:water_fresh_source",
})
]]--
