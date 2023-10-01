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
minetest.register_craftitem(":technic:chromium_lump", {
	description = S("Chromium Lump"),
	inventory_image = "technic_chromium_lump.png",
})

local recipes = {
	{"technic:chromium_lump",      "technic:chromium_dust 2"},
}
for _, data in pairs(recipes) do
	technic.register_grinder_recipe({input = {data[1]}, output = data[2]})
end

minetest.register_craftitem(":technic:chromium_ingot", {
	description = S("Chromium Ingot"),
	inventory_image = "technic_chromium_ingot.png",
})
minetest.register_craft({
	type = 'cooking',
	recipe = "technic:chromium_lump",
	output = "technic:chromium_ingot",
})
register_dust("Chromium",        "technic:chromium_ingot")

minetest.register_node(":technic:chromium_block", {
	description = S("Chromium Block"),
	tiles = { "technic_chromium_block.png" },
	is_ground_content = true,
	groups = {cracky=1, level=2},
	sounds = default.node_sound_stone_defaults()
})
register_block("technic:chromium_block", "technic:chromium_ingot")
]]--
