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
minetest.register_craftitem(":technic:sulfur_lump", {
	description = S("Sulfur Lump"),
	inventory_image = "technic_sulfur_lump.png",
})

local recipes = {
	{"technic:sulfur_lump",        "technic:sulfur_dust 2"},
}
for _, data in pairs(recipes) do
	technic.register_grinder_recipe({input = {data[1]}, output = data[2]})
end
register_dust("Sulfur",          nil)
]]--
