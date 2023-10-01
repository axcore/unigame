---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    technic/technic_worldgen
-- Code:    LGPL 2.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
register_dust("Wrought Iron",    "technic:wrought_iron_ingot")

minetest.register_alias("technic:wrought_iron_ingot", "default:steel_ingot")
minetest.override_item("default:steel_ingot", {
	description = S("Wrought Iron Ingot"),
	inventory_image = "technic_wrought_iron_ingot.png",
})
minetest.register_craft({
	type = 'cooking',
	recipe = "technic:cast_iron_ingot",
	cooktime = 2,
	output = "technic:wrought_iron_ingot",
})
minetest.register_craft({
	type = 'cooking',
	recipe = "technic:carbon_steel_ingot",
	cooktime = 2,
	output = "technic:wrought_iron_ingot",
})

minetest.register_alias("technic:wrought_iron_block", "default:steelblock")
minetest.override_item("default:steelblock", {
	description = S("Wrought Iron Block"),
	tiles = { "technic_wrought_iron_block.png" },
})
]]--
