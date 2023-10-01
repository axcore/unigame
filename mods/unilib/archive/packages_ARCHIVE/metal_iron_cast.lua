---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    technic/technic_worldgen
-- Code:    LGPL 2.0
-- Media:   unknown
--
-- From:    technic
-- Code:    LGPL 2.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
register_dust("Cast Iron",       "technic:cast_iron_ingot")

minetest.register_craftitem(":technic:cast_iron_ingot", {
	description = S("Cast Iron Ingot"),
	inventory_image = "technic_cast_iron_ingot.png",
})
minetest.register_craft({
	type = 'cooking',
	recipe = minetest.registered_aliases["technic:wrought_iron_ingot"],
	output = "technic:cast_iron_ingot",
})

minetest.register_node(":technic:cast_iron_block", {
	description = S("Cast Iron Block"),
	tiles = { "technic_cast_iron_block.png" },
	is_ground_content = true,
	groups = {cracky=1, level=2},
	sounds = default.node_sound_stone_defaults()
})
register_block("technic:cast_iron_block", "technic:cast_iron_ingot")
]]--
