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
function flowers.veiled_mushroom_spread(pos, node)
	if minetest.get_node_light(pos, 0.5) > 10 then
		if minetest.get_node_light(pos, nil) >= 11 then
			minetest.remove_node(pos)
		end
		return
	end
	local positions = minetest.find_nodes_in_area_under_air(
		{x = pos.x - 75, y = pos.y - 50, z = pos.z - 75},
		{x = pos.x + 75, y = pos.y + 50, z = pos.z + 75},
		{"default:stone_with_tin"})
	if #positions == 0 then
		return
	end
	local pos2 = positions[math.random(#positions)]
	pos2.y = pos2.y + 1
	if minetest.get_node_light(pos2, 0.5) <= 10 then
		minetest.set_node(pos2, {name = node.name})
	end
end

minetest.register_node("cropocalypse:veiled_mushroom", {
	description = ("Veiled Mushroom"),
	tiles = {"cropocalypse_veiled_mushroom.png"},
	inventory_image = "cropocalypse_veiled_mushroom.png",
	wield_image = "cropocalypse_veiled_mushroom.png",
	drawtype = "plantlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {veiled_mushroom = 1, food_veiled_mushroom = 1, snappy = 3, attached_node = 1, flammable = 1},
	drop = "cropocalypse:veiled_mushroom",
	sounds = default.node_sound_leaves_defaults(),
	on_use = minetest.item_eat(4),
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
	},
	light_source = 9,
})

minetest.register_decoration({
	name = "cropocalypse:veiled_mushroom",
	deco_type = "simple",
	place_on = {"default:dirt_with_rainforest_litter"},
	sidelen = 16,
	noise_params = {
		offset = -0.1,
		scale = 0.1,
		spread = {x = 10, y = 10, z = 10},
		seed = 6712,
		octaves = 3,
		persist = 0.7
	},
	biomes = {"rainforest"},
	y_max = 31000,
	y_min = 1,
	decoration = "cropocalypse:veiled_mushroom",
})

minetest.register_abm({
	label = "Veiled Mushroom Spread",
	nodenames = {"group:veiled_mushroom"},
	interval = 11,
	chance = 75,
	action = function(...)
		flowers.veiled_mushroom_spread(...)
	end,
})

if minetest.features.particlespawner_tweenable then
	minetest.register_abm({
		nodenames = { "group:veiled_mushroom" },
		interval = 1,
		chance = 3,
		catch_up = false,
		action = function(pos, node)
			minetest.add_particlespawner({
				pos = { min = vector.add(pos, vector.new(-1.5, 0, -1.5)), max = vector.add(pos, vector.new(1.5, 1.5, 1.5)) },
				vel = { min = vector.new(0, 0, 0), max = vector.new( 0, 0.15, 0) },
				acc = { min = vector.new(0, 0.1, 0), max = vector.new(0, 0.3, 0) },
				time = 1,
				amount = 1,
				exptime = 3,
				collisiondetection = true,
				collision_removal = true,
				glow = 14,
				texpool = {
					{ name = "particle_veiled.png", alpha_tween = { 1, 0 }, scale = 1,
					animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 1}},
				}
			})
		end
	})
end
]]--
