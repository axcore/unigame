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
minetest.register_craftitem(":technic:uranium_lump", {
	description = S("Uranium Lump"),
	inventory_image = "technic_uranium_lump.png",
})

local recipes = {
	{"technic:uranium_lump",       "technic:uranium_dust 2"},
}
for _, data in pairs(recipes) do
	technic.register_grinder_recipe({input = {data[1]}, output = data[2]})
end

minetest.register_craftitem(":technic:uranium_ingot", {
	description = S("Uranium Ingot"),
	inventory_image = "technic_uranium_ingot.png",
	groups = {uranium_ingot=1},
})
minetest.register_craft({
	type = 'cooking',
	recipe = "technic:uranium_lump",
	output = "technic:uranium_ingot",
})

minetest.register_node(":technic:uranium_block", {
	description = S("Uranium Block"),
	tiles = { "technic_uranium_block.png" },
	is_ground_content = true,
	groups = {uranium_block=1, cracky=1, level=2, radioactive=2},
	sounds = default.node_sound_stone_defaults()
})
register_block("technic:uranium_block", "technic:uranium_ingot")
]]--
