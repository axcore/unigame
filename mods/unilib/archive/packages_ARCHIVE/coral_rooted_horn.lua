---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xocean
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("xocean:horn", {
	description = "Horn Coral",
	drawtype = "plantlike_rooted",
	waving = 1,
	paramtype = "light",
	tiles = {"xocean_coral_horn.png"},
	special_tiles = {{name = "xocean_horn.png", tileable_vertical = true}},
	inventory_image = "xocean_horn.png",
	groups = {snappy = 3},
	drop = "xocean:skeleton_horn",
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	node_dig_prediction = "default:coral_brown",
	node_placement_prediction = "",
	sounds = default.node_sound_stone_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),

	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" or not placer then
			return itemstack
		end

		local player_name = placer:get_player_name()
		local pos_under = pointed_thing.under
		local pos_above = pointed_thing.above

		if minetest.get_node(pos_under).name ~= "default:coral_brown" or
				minetest.get_node(pos_above).name ~= "default:water_source" then
			return itemstack
		end

		if minetest.is_protected(pos_under, player_name) or
				minetest.is_protected(pos_above, player_name) then
			minetest.chat_send_player(player_name, "Node is protected")
			minetest.record_protection_violation(pos_under, player_name)
			return itemstack
		end

		minetest.set_node(pos_under, {name = "xocean:horn"})
		if not (creative and creative.is_enabled_for(player_name)) then
			itemstack:take_item()
		end

		return itemstack
	end,

	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "xocean:horn_block"})
	end,
})

minetest.register_node("xocean:skeleton_horn", {
	description = "Horn Coral Skeleton",
	drawtype = "plantlike_rooted",
	waving = 1,
	paramtype = "light",
	tiles = {"xocean_coral_horn_skeleton.png"},
	special_tiles = {{name = "xocean_horn_skeleton.png", tileable_vertical = true}},
	inventory_image = "xocean_horn_skeleton.png",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	drop = "xocean:skeleton_horn",
	node_dig_prediction = "xocean:horn_skeleton",
	node_placement_prediction = "",
	sounds = default.node_sound_stone_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),

	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" or not placer then
			return itemstack
		end

		local player_name = placer:get_player_name()
		local pos_under = pointed_thing.under
		local pos_above = pointed_thing.above

		-- if minetest.get_node(pos_under).name ~= "xocean:horn_skeleton" or
		if minetest.get_node(pos_under).name ~= "default:coral_skeleton" or
				minetest.get_node(pos_above).name ~= "default:water_source" then
			return itemstack
		end

		if minetest.is_protected(pos_under, player_name) or
				minetest.is_protected(pos_above, player_name) then
			minetest.chat_send_player(player_name, "Node is protected")
			minetest.record_protection_violation(pos_under, player_name)
			return itemstack
		end

		minetest.set_node(pos_under, {name = "xocean:skeleton_horn"})
		if not (creative and creative.is_enabled_for(player_name)) then
			itemstack:take_item()
		end

		return itemstack
	end,

	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "xocean:horn_skeleton"})
	end,
})

minetest.register_decoration({
		name = "xocean:horn_plant",
		deco_type = "simple",
		place_on = {"xocean:brain_block","xocean:tube_block","default:coral_orange","default:coral_brown","xocean:bubble_block"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = -0.04,
			scale = 1.0,
			spread = {x = 20, y = 20, z = 20},
			seed = 87112,
			octaves = 3,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -5,
		y_min = -50,
		flags = "force_placement",
		decoration = "xocean:horn",
		param2 = 48,
		param2_max = 96,
	})
    
minetest.register_decoration({
		name = "xocean:horn_plant_dead",
		deco_type = "simple",
		place_on = {"xocean:brain_block","xocean:tube_block","default:coral_orange","default:coral_brown","xocean:bubble_block"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = -0.04,
			scale = 1.0,
			spread = {x = 20, y = 20, z = 20},
			seed = 87112,
			octaves = 3,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -5,
		y_min = -50,
		flags = "force_placement",
		decoration = "xocean:skeleton_horn",
		param2 = 48,
		param2_max = 96,
	})
]]--
