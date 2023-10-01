---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
function flowers.saucer_mushroom_spread(pos, node)
	if minetest.get_node_light(pos, 0.5) > 10 then
		if minetest.get_node_light(pos, nil) >= 11 then
			minetest.remove_node(pos)
		end
		return
	end
	local positions = minetest.find_nodes_in_area_under_air(
		{x = pos.x - 75, y = pos.y - 50, z = pos.z - 75},
		{x = pos.x + 75, y = pos.y + 50, z = pos.z + 75},
		{"default:stone_with_coal"})
	if #positions == 0 then
		return
	end
	local pos2 = positions[math.random(#positions)]
	pos2.y = pos2.y + 1
	if minetest.get_node_light(pos2, 0.5) <= 10 then
		minetest.set_node(pos2, {name = node.name})
	end
end

minetest.register_node("cropocalypse:saucer_mushroom", {
	description = ("Saucer Mushroom"),
	tiles = {"cropocalypse_saucer_mushroom.png"},
	inventory_image = "cropocalypse_saucer_mushroom.png",
	wield_image = "cropocalypse_saucer_mushroom.png",
	drawtype = "plantlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {saucer_mushroom = 1, food_saucer_mushroom = 1, snappy = 3, attached_node = 1, flammable = 1},
	drop = "cropocalypse:saucer_mushroom",
	sounds = default.node_sound_leaves_defaults(),
	on_use = minetest.item_eat(4),
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
	},
	light_source = 9,
})

minetest.register_decoration({
	name = "cropocalypse:saucer_mushroom",
	deco_type = "simple",
	place_on = {"default:dirt_with_rainforest_litter"},
	sidelen = 16,
	noise_params = {
		offset = -0.1,
		scale = 0.1,
		spread = {x = 10, y = 10, z = 10},
		seed = 6649,
		octaves = 3,
		persist = 0.7
	},
	biomes = {"rainforest"},
	y_max = 31000,
	y_min = 1,
	decoration = "cropocalypse:saucer_mushroom",
})

minetest.register_abm({
	label = "Saucer Mushroom Spread",
	nodenames = {"group:saucer_mushroom"},
	interval = 11,
	chance = 75,
	action = function(...)
		flowers.saucer_mushroom_spread(...)
	end,
})
]]--
