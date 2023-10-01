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
minetest.register_node("moreplants:groundfung", {
	description = "Ground fungus",
	drawtype = "firelike",
	tiles = {
		"moreplants_groundfung.png",
		"moreplants_trans.png",
		"moreplants_groundfung.png",
		"moreplants_groundfung.png",
		"moreplants_groundfung.png",
		"moreplants_groundfung.png"
	},
	groups = {snappy=3, flammable=1, attached_node=1, flora=1},
	is_ground_content=true,
	buildable_to = true, 
	walkable = false,
	inventory_image = "moreplants_groundfung.png",
	paramtype = "light",
	sunlight_propagates=true,
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.1, 0.5}
	},
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:snowblock", "default:dirt_with_snow"},
	sidelen = 16,
	fill_ratio = 0.02,
	biomes = {"taiga"},
	decoration = "moreplants:groundfung",
	height = 1,
})
]]--
