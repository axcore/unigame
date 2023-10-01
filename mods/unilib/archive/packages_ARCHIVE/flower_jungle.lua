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
minetest.register_node("moreplants:jungleflower", {
	description = "Jungle flower",
	drawtype = "plantlike",
	tiles = {"moreplants_jungleflower1.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	inventory_image = "moreplants_jungleflower1.png",
	visual_scale = 1.1,
	wield_scale = {x=0.5, y=0.5, z=0.5},
	groups = {snappy=3, flammable=1, attached_node=1, flower=1},
	selection_box = {
		type = "fixed",
		fixed = {-0.4, -0.5, -0.4, 0.4, 0.4, 0.4}
	},
	walkable = false,
	waving = 1,
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_rainforest_litter", "default:dirt_with_grass"},
	sidelen = 16,
	fill_ratio = 0.02,
	biomes = {"rainforest"},
	decoration = "moreplants:jungleflower",
	height = 1,
})
]]--
