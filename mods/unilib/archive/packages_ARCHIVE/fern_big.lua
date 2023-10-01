---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("moreplants:bigfern", {
	description = "Big Fern",
	drawtype = "plantlike",
	tiles = {"moreplants_bigfern.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	inventory_image = "moreplants_bigfern.png",
	visual_scale = 1.5,
	wield_scale = {x=0.5, y=0.5, z=0.5},
	groups = {snappy=3, flammable=1, attached_node=1, flora=1},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
	waving = 1,
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {
		"default:dirt_with_rainforest_litter",
		"default:dirt_with_grass",
		"default:dirt_with_coniferous_litter",
	},
	sidelen = 16,
	fill_ratio = 0.01,
	biomes = {"rainforest", "coniferous_forest"},
	decoration = "moreplants:bigfern",
	height = 1,
})
]]--
