---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("mapgen:dead_grass_1", {
	description = "Dead Grass",
	drawtype = "plantlike",
	tiles = {"mapgen_dead_grass_2.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true,
	sunlight_propagates = true,
	inventory_image = "mapgen_dead_grass_1.png",
	groups = {snappy=3, flammable=1, attached_node=1, flora=1, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
	drop = "mapgen:dead_grass_5",
})

minetest.register_node("mapgen:dead_grass_2", {
	description = "Dead Grass",
	drawtype = "plantlike",
	tiles = {"mapgen_dead_grass_3.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true,
	sunlight_propagates = true,
	inventory_image = "mapgen_dead_grass_2.png",
	groups = {snappy=3, flammable=1, attached_node=1, flora=1, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
	drop = "mapgen:dead_grass_5",
})

minetest.register_node("mapgen:dead_grass_3", {
	description = "Dead Grass",
	drawtype = "plantlike",
	tiles = {"mapgen_dead_grass_4.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true,
	sunlight_propagates = true,
	inventory_image = "mapgen_dead_grass_3.png",
	groups = {snappy=3, flammable=1, attached_node=1, flora=1, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
	drop = "mapgen:dead_grass_5",
})

minetest.register_node("mapgen:dead_grass_4", {
	description = "Dead Grass",
	drawtype = "plantlike",
	tiles = {"mapgen_dead_grass_5.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true,
	sunlight_propagates = true,
	inventory_image = "mapgen_dead_grass_4.png",
	groups = {snappy=3, flammable=1, attached_node=1, flora=1, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
	drop = "mapgen:dead_grass_5",
})

minetest.register_node("mapgen:dead_grass_5", {
	description = "Dead Grass",
	drawtype = "plantlike",
	tiles = {"mapgen_dead_grass_5.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true,
	sunlight_propagates = true,
	inventory_image = "mapgen_dead_grass_4.png",
	groups = {snappy=3, flammable=1, attached_node=1, flora=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
	on_construct = function(pos)
		local num = math.random(1,5)
		minetest.set_node(pos, {name="mapgen:dead_grass_"..num})
	end
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_dry_grass"},
	sidelen = 6,
	fill_ratio = 0.002,
	biomes = {"savanna"},
	decoration = "mapgen:dead_grass_1",
	height = 1,
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_dry_grass"},
	sidelen = 6,
	fill_ratio = 0.002,
	biomes = {"savanna"},
	decoration = "mapgen:dead_grass_2",
	height = 1,
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_dry_grass", "default:desert_sand"},
	sidelen = 6,
	fill_ratio = 0.002,
	biomes = {"savanna", "desert"},
	decoration = "mapgen:dead_grass_3",
	height = 1,
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_dry_grass", "default:desert_sand"},
	sidelen = 6,
	fill_ratio = 0.002,
	biomes = {"savanna", "desert"},
	decoration = "mapgen:dead_grass_4",
	height = 1,
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_dry_grass", "default:desert_sand"},
	sidelen = 6,
	fill_ratio = 0.002,
	biomes = {"savanna", "desert"},
	decoration = "mapgen:dead_grass_5",
	height = 1,
})
]]--
