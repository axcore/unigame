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
minetest.register_node("pedology:snow_slush", {
	description = S("slushy snow"),
	tiles = { "pedology_snow_slush.png" },
	sounds = { footstep = { name = "pedology_snow_soft_footstep", gain = 1 } },
	is_ground_content = true,
	groups = { crumbly = 1, level = 1, melts = 1, falling_node = 1},
	drop = "",
	freezemelt = "pedology:water_fresh_source",
})
]]--
