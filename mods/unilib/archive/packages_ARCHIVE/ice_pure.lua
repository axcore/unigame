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
minetest.register_node("pedology:ice_pure", {
	description = S("pure ice"),
	drawtype = "glasslike",
	paramtype = "light",
	tiles = { "pedology_ice_pure.png" },
	inventory_image = minetest.inventorycube( "pedology_ice_pure.png" ),
	sounds = { footstep = { name = "pedology_ice_pure_footstep", gain = 0.8 } },
	is_ground_content = true,
	groups = { cracky = 3, level = 2, melts = 1 },
	drop = "pedology:lump_ice_pure 4",
	freezemelt = "pedology:water_fresh_source",
})

minetest.register_craftitem("pedology:lump_ice_pure", {
	description = S("small pure ice cube"),
	wield_image = "pedology_lump_ice_pure.png",
	inventory_image = "pedology_lump_ice_pure.png",
})
]]--
