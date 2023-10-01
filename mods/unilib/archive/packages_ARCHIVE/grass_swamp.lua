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
minetest.register_node("mapgen:swamp_grass_1", {
	description = "swamp Grass",
	drawtype = "plantlike",
	tiles = {"mapgen_swamp_grass_1.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true,
	sunlight_propagates = true,
	drop = "mapgen:swamp_grass_5",
	inventory_image = "mapgen_swamp_grass_1.png",
	groups = {snappy=3, flammable=1, attached_node=1, flora=1, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
})

minetest.register_node("mapgen:swamp_grass_2", {
	description = "swamp Grass",
	drawtype = "plantlike",
	tiles = {"mapgen_swamp_grass_2.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true,
	sunlight_propagates = true,
	drop = "mapgen:swamp_grass_5",
	inventory_image = "mapgen_swamp_grass_2.png",
	groups = {snappy=3, flammable=1, attached_node=1, flora=1, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
})

minetest.register_node("mapgen:swamp_grass_3", {
	description = "swamp Grass",
	drawtype = "plantlike",
	tiles = {"mapgen_swamp_grass_3.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true,
	sunlight_propagates = true,
	drop = "mapgen:swamp_grass_5",
	inventory_image = "mapgen_swamp_grass_3.png",
	groups = {snappy=3, flammable=1, attached_node=1, flora=1, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
})

minetest.register_node("mapgen:swamp_grass_4", {
	description = "swamp Grass",
	drawtype = "plantlike",
	tiles = {"mapgen_swamp_grass_4.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true,
	sunlight_propagates = true,
	drop = "mapgen:swamp_grass_5",
	inventory_image = "mapgen_swamp_grass_4.png",
	groups = {snappy=3, flammable=1, attached_node=1, flora=1, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
})

minetest.register_node("mapgen:swamp_grass_5", {
	description = "swamp Grass",
	drawtype = "plantlike",
	tiles = {"mapgen_swamp_grass_5.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true,
	sunlight_propagates = true,
	drop = "mapgen:swamp_grass_5",
	inventory_image = "mapgen_swamp_grass_5.png",
	groups = {snappy=3, flammable=1, attached_node=1, flora=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
	on_construct = function(pos)
		local num = math.random(1,5)
		minetest.set_node(pos, {name="mapgen:swamp_grass_"..num})
	end,
})

local function register_swamp_grass_decoration(offset, scale, length)
	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"mapgen:dirt_with_swampgrass", "default:dirt"},
		sidelen = 16,
		noise_params = {
			offset = offset,
			scale = scale,
			spread = {x = 200, y = 200, z = 200},
			seed = 329,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"swamp",},
		y_min = 1,
		y_max = 31000,
		decoration = "mapgen:swamp_grass_" .. length,
	})
end

	register_swamp_grass_decoration(-0.03,  0.09,  5)
	register_swamp_grass_decoration(-0.015, 0.075, 4)
	register_swamp_grass_decoration(0,      0.06,  3)
	register_swamp_grass_decoration(0.015,  0.045, 2)
	register_swamp_grass_decoration(0.03,   0.03,  1)
]]--
