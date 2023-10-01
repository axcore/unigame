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
minetest.register_node("moreplants:deadweed", {
	description = "dead weed",
	drawtype = "plantlike",
	tiles = {"moreplants_deadweed.png"},
	paramtype = "light",
	light_source = 2,
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	inventory_image = "moreplants_deadweed.png",
	visual_scale = 1,
	wield_scale = {x=0.5, y=0.5, z=0.5},
	groups = {snappy=3, flammable=1, attached_node=1, flora=1},
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, 0, 0.2}
	},
	walkable = false,
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:snowblock", "default:dirt_with_snow"},
	sidelen = 26,
	fill_ratio = 0.02,
	biomes = {"taiga"},
	decoration = "moreplants:deadweed",
	height = 1,
})
]]--
