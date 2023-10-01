---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    snow
-- Code:    GPL 3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
-- Shrub(s)
nodedef = {
	description = "Snow Shrub",
	tiles = {"snow_shrub.png"},
	inventory_image = "snow_shrub.png",
	wield_image = "snow_shrub.png",
	drawtype = "plantlike",
	paramtype = "light",
	waving = 1,
	sunlight_propagates = true,
	walkable = false,
	is_ground_content = true,
	buildable_to = true,
	groups = {snappy=3,flammable=3,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, -5/16, 0.3},
	},
	furnace_burntime = 5,
}
minetest.register_node("snow:shrub", table.copy(nodedef))

nodedef.tiles = {"snow_shrub.png^snow_shrub_covering.png"}
nodedef.inventory_image = "snow_shrub.png^snow_shrub_covering.png"
nodedef.wield_image = "snow_shrub.png^snow_shrub_covering.png"
nodedef.paramtype2 = "degrotate"
nodedef.drop = "snow:shrub"
nodedef.furnace_burntime = 3
minetest.register_node("snow:shrub_covered", nodedef)

--Dry shrubs.
minetest.register_decoration({
	deco_type = "simple",
	place_on = "default:dirt_with_snow",
	sidelen = 16,
	fill_ratio = 0.005,
	biomes = {"snow_biome_default"},
	decoration = "default:dry_shrub",
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = "default:dirt_with_snow",
	sidelen = 16,
	fill_ratio = 0.05,
	biomes = {"snow_biome_forest", "snow_biome_lush"},
	decoration = "default:dry_shrub",
})
]]--
