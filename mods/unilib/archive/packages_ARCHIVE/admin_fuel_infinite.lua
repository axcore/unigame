---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    maptools
-- Code:    zlib
-- Media:   zlib
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("maptools:infinitefuel", {
	description = S("Infinite Fuel"),
	inventory_image = "maptools_infinitefuel.png",
	stack_max = 65535,
	groups = {not_in_creative_inventory = maptools.creative},
})
minetest.register_craft({
	type = "fuel",
	recipe = "maptools:infinitefuel",
	burntime = 1000000000,
})
]]--
