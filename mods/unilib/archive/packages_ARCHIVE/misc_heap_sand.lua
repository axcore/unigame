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
minetest.register_node("forest:sand_way", {
	description = "Sand heap",
	drawtype = "raillike",
	tiles = {"sand_way.png", "sand_way_curved.png", "sand_way_t_junction.png", "sand_way_crossing.png"},
	inventory_image = "sand_heap.png",
	wield_image = "sand_heap.png",
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
	output = 'default:sand',
	recipe = {
		{'forest:sand_way', 'forest:sand_way', 'forest:sand_way'},
		{'forest:sand_way', 'forest:sand_way', 'forest:sand_way'},
		{'forest:sand_way', 'forest:sand_way', 'forest:sand_way'},
	}
})
minetest.register_craft({
	output = 'forest:sand_way 9',
	recipe = {
		{'default:sand'},
	}
})
]]--
