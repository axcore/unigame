---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("default:stick", {
	description = S("Stick"),
	inventory_image = "default_stick.png",
	groups = {stick = 1, flammable = 2},
})
minetest.register_craft({
	output = "default:stick 4",
	recipe = {
		{"group:wood"},
	}
})
minetest.register_craft({
	type = "fuel",
	recipe = "group:stick",
	burntime = 1,
})
minetest.register_craft({
	output = "default:stick",
	recipe = {{"default:dry_shrub"},}
})
minetest.register_craft({
	output = "default:stick",
	recipe = {{"group:sapling"},}
})
]]--
