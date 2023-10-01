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
minetest.register_node("moreplants:clover", {
	description = "Clover",
	drawtype = "firelike",
	tiles = {
		"moreplants_clover.png",
		"moreplants_trans.png",
		"moreplants_clover.png",
		"moreplants_clover.png",
		"moreplants_clover.png",
		"moreplants_clover.png"
	},
	groups = {snappy=3, flammable=1, attached_node=1, flora=1},
	is_ground_content=true,
	buildable_to = true, 
	sunlight_propagates = true,
	walkable = false,
	inventory_image = "moreplants_clover.png",
	paramtype = "light",
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.1, 0.5}
	},
	waving = 1,
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = "default:dirt_with_grass",
	sidelen = 16,
	fill_ratio = 0.01,
	biomes = {"deciduous_forest","grassland"},
	decoration = "moreplants:clover",
	height = 1,
})
]]--
