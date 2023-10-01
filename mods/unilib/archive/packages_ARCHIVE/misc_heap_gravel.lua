---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    forest
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("forest:gravel_way", {
	description = "Gravel heap",
	drawtype = "raillike",
	tiles = {"gravel_way.png", "gravel_way_curved.png", "gravel_way_t_junction.png", "gravel_way_crossing.png"},
	inventory_image = "gravel_heap.png",
	wield_image = "gravel_heap.png",
	paramtype = "light",
	walkable = false,
	is_ground_content = false,
	selection_box = {
		type = "fixed",
                fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	groups = {dig_immediate=3,way=1},
	sounds = default.node_sound_sand_defaults(),
})
minetest.register_craft({
	output = 'default:gravel',
	recipe = {
		{'forest:gravel_way', 'forest:gravel_way', 'forest:gravel_way'},
		{'forest:gravel_way', 'forest:gravel_way', 'forest:gravel_way'},
		{'forest:gravel_way', 'forest:gravel_way', 'forest:gravel_way'},
	}
})
minetest.register_craft({
	output = 'forest:gravel_way 9',
	recipe = {
		{'default:gravel'},
	}
})
]]--
