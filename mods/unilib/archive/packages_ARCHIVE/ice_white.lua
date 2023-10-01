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
minetest.register_node("pedology:ice_white", {
	description = S("white ice"),
	tiles = { "pedology_ice_white.png" },
	sounds = { footstep = { name = "pedology_ice_white_footstep", gain = 0.8 } },
	is_ground_content = true,
	groups = { cracky = 3, level = 1, melts = 1 },
	drop = "pedology:lump_ice_white 4",
	freezemelt = "pedology:water_fresh_source",
})

minetest.register_craftitem("pedology:lump_ice_white", {
	description = S("small white ice cube"),
	wield_image = "pedology_lump_ice_white.png",
	inventory_image = "pedology_lump_ice_white.png",
})
]]--
