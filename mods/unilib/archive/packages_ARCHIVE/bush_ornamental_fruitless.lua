---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/bushes_classic
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
bushes_classic.bushes_descriptions = {
	{S("Mixed Berry"), S("Raw Mixed Berry pie"), S("Cooked Mixed Berry pie"), S("Slice of Mixed Berry pie"), S("Basket with Mixed Berry pies"), S("Currently fruitless Bush")}
}

minetest.register_node(":bushes:basket_empty", {
    description = S("Basket"),
	drawtype = "mesh",
	mesh = "bushes_basket_empty.obj",
	tiles = { "bushes_basket.png" },
	paramtype = "light",
	paramtype2 = "facedir",
    groups = { dig_immediate = 3 },
})
minetest.register_craft({
	output = "bushes:basket_empty",
	recipe = {
		{ "default:stick", "default:stick", "default:stick" },
		{ "", "default:stick", "" },
	},
})

-- regrow berries (uses a base abm instead of biome_lib because of the use of metadata).
minetest.register_abm({
	nodenames = {"bushes:fruitless_bush"},
	neighbors = {"group:soil", "group:potting_soil"},
	interval = 500,
	chance = 5,
	action = function(pos, node, active_object_count, active_object_count_wider)

		local meta = minetest.get_meta(pos)
		local bush_name = meta:get_string("bush_type")

		if bush_name and bush_name ~= "" then
			local dirtpos = {x = pos.x, y = pos.y-1, z = pos.z}
			local dirt = minetest.get_node(dirtpos)
			local is_soil = minetest.get_item_group(dirt.name, "soil") or minetest.get_item_group(dirt.name, "potting_soil")

			if is_soil and (dirt.name == "farming:soil_wet" or math.random(1,3) == 1) then
				minetest.swap_node( pos, {name = "bushes:" .. bush_name .. "_bush"})
			end
		end
	end
})
]]--
