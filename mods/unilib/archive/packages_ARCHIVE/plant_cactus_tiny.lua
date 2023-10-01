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
minetest.register_node("moreplants:cactus", {
	description = "Small Cactus",
	drawtype = "plantlike",
	tiles = {"moreplants_cactus.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	inventory_image = "moreplants_cactus.png",
	visual_scale = 1,
	wield_scale = {x=0.5, y=0.5, z=0.5},
	groups = {snappy=3, flammable=1, attached_node=1, flora=1},
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0, 0.3}
	},
	walkable = false,
	damage_per_second = 1
})
minetest.register_craft({
	output = "default:cactus 1",
	recipe = {
		{"moreplants:cactus", "moreplants:cactus", "moreplants:cactus"},
		{"moreplants:cactus", "moreplants:cactus", "moreplants:cactus"},
		{"moreplants:cactus", "moreplants:cactus",  "moreplants:cactus"}
	}
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = "default:desert_sand",
	sidelen = 26,
	fill_ratio = 0.005,
	biomes = {"desert"},
	decoration = "moreplants:cactus",
	height = 1,
})
]]--
