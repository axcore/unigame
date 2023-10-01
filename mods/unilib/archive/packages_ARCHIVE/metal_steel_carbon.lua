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
register_dust("Carbon Steel",    "technic:carbon_steel_ingot")

minetest.register_craftitem(":technic:carbon_steel_ingot", {
	description = S("Carbon Steel Ingot"),
	inventory_image = "technic_carbon_steel_ingot.png",
})

minetest.register_node(":technic:carbon_steel_block", {
	description = S("Carbon Steel Block"),
	tiles = { "technic_carbon_steel_block.png" },
	is_ground_content = true,
	groups = {cracky=1, level=2},
	sounds = default.node_sound_stone_defaults()
})
register_block("technic:carbon_steel_block", "technic:carbon_steel_ingot")
]]--
