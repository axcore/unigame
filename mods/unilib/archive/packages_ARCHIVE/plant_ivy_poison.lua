---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/poisonivy
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node('poisonivy:seedling', {
	description = S("Poison ivy (seedling)"),
	drawtype = 'plantlike',
	waving = 1,
	tiles = { 'poisonivy_seedling.png' },
	inventory_image = 'poisonivy_seedling.png',
	wield_image = 'poisonivy_seedling.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = false,
	groups = { snappy = 3, poisonivy=1, flora_block=1 },
	sounds = default.node_sound_leaves_defaults(),
	buildable_to = true,
})

minetest.register_node('poisonivy:sproutling', {
	description = S("Poison ivy (sproutling)"),
	drawtype = 'plantlike',
	waving = 1,
	tiles = { 'poisonivy_sproutling.png' },
	inventory_image = 'poisonivy_sproutling.png',
	wield_image = 'poisonivy_sproutling.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = false,
	groups = { snappy = 3, poisonivy=1, flora_block=1 },
	sounds = default.node_sound_leaves_defaults(),
	buildable_to = true,
})

minetest.register_node('poisonivy:climbing', {
	description = S("Poison ivy (climbing plant)"),
	drawtype = 'signlike',
	tiles = { 'poisonivy_climbing.png' },
	inventory_image = 'poisonivy_climbing.png',
	wield_image = 'poisonivy_climbing.png',
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = 'wallmounted',
	walkable = false,
	groups = { snappy = 3, poisonivy=1, flora_block=1 },
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "wallmounted",
		--wall_side = = <default>
	},
	buildable_to = true,
})

biome_lib.register_active_spawner({
	spawn_delay = SPAWN_DELAY,
	spawn_plants = {"poisonivy:seedling"},
	avoid_radius = 10,
	spawn_chance = SPAWN_CHANCE/10,
	spawn_surfaces = {"default:dirt_with_grass"},
	avoid_nodes = {"group:poisonivy", "group:flower", "group:flora"},
	seed_diff = poisonivy_seed_diff,
	light_min = 7,
	alt_wallnode = "poisonivy:climbing",
	verticals_list = walls_list
})
]]--
