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
minetest.register_node("mapgen:seagrass_1", {
	description = "Sea Grass",
	drawtype = "plantlike",
	tiles = {"mapgen_seagrass_1.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true,
	sunlight_propagates = true,
	waving = 1,
	inventory_image = "mapgen_seagrass_1.png",
	groups = {snappy=3, flammable=1, attached_node=1, sea=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	drop = "mapgen:seagrass_1",
	walkable = false,
	on_construct = function(pos)
		local num = math.random(1,3)
		minetest.set_node(pos, {name="mapgen:seagrass_"..num})
	end,
})

minetest.register_node("mapgen:seagrass_2", {
	description = "Sea Grass",
	drawtype = "plantlike",
	tiles = {"mapgen_seagrass_2.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true,
	sunlight_propagates = true,
	waving = 1,
	inventory_image = "mapgen_seagrass_2.png",
	groups = {snappy=3, flammable=1, attached_node=1, sea=1, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	drop = "mapgen:seagrass_1",
	walkable = false,
})

minetest.register_node("mapgen:seagrass_3", {
	description = "Sea Grass",
	drawtype = "plantlike",
	tiles = {"mapgen_seagrass_3.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true,
	sunlight_propagates = true,
	waving = 1,
	inventory_image = "mapgen_seagrass_3.png",
	groups = {snappy=3, flammable=1, attached_node=1, sea=1, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	drop = "mapgen:seagrass_1",
	walkable = false,
})
]]--
