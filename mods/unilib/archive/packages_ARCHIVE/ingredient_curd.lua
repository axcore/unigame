---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cheese
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED / CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("cheese:curd", {
	description = S("Curd"),
	inventory_image = "curd.png",
	groups = {milk_product = 1},
})

local default = "cheese:toma"
if minetest.get_modpath("mobs") then
	default = "mobs:cheese"
elseif minetest.get_modpath("petz") then
	default = "petz:cheese"
end

-- def here because im clearing crafts for those cheeses, otherwise this gets cleared too
minetest.register_craft({
	type = "cooking",
	output = default,
	recipe = "cheese:curd",
	cooktime = 20,
})
]]--
