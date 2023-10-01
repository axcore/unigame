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
minetest.register_craftitem(":technic:lead_lump", {
	description = S("Lead Lump"),
	inventory_image = "technic_lead_lump.png",
})

local recipes = {
	{"technic:lead_lump",          "technic:lead_dust 2"},
}
for _, data in pairs(recipes) do
	technic.register_grinder_recipe({input = {data[1]}, output = data[2]})
end
register_dust("Lead",            "technic:lead_ingot")

minetest.register_craftitem(":technic:lead_ingot", {
	description = S("Lead Ingot"),
	inventory_image = "technic_lead_ingot.png",
})
minetest.register_craft({
	type = 'cooking',
	recipe = "technic:lead_lump",
	output = "technic:lead_ingot",
})

minetest.register_node(":technic:lead_block", {
	description = S("Lead Block"),
	tiles = { "technic_lead_block.png" },
	is_ground_content = true,
	groups = {cracky=1, level=2},
	sounds = default.node_sound_stone_defaults()
})
register_block("technic:lead_block", "technic:lead_ingot")
]]--
