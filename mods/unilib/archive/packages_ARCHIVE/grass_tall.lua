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
minetest.register_node("mapgen:tallgrass", {
	description = "Tall Grass",
	drawtype = "plantlike",
	tiles = {"mapgen_longgrass.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true,
	sunlight_propagates = true,
	inventory_image = "mapgen_longgrass.png",
	visual_scale = 2,
	wield_scale = {x=0.5, y=0.5, z=0.5},
	groups = {snappy=3, flammable=1, attached_node=1, flora=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = "default:dirt_with_grass", "mapgen:dirt_with_leafygrass", "mapgen:dirt_with_swampgrass",
	sidelen = 16,
	fill_ratio = 0.01,
	biomes = {"grassland", "deciduous_forest", "coniferous_forest_tall", "swamp"},
	decoration = "mapgen:tallgrass",
	height = 1,
})
]]--
