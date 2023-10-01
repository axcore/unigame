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
minetest.register_node("forest:desert_sand_way", {
	description = "Desert sand heap",
	drawtype = "raillike",
	tiles = {"desert_sand_way.png", "desert_sand_way_curved.png", "desert_sand_way_t_junction.png", "desert_sand_way_crossing.png"},
	inventory_image = "desert_sand_heap.png",
	wield_image = "desert_sand_heap.png",
	paramtype = "light",
	walkable = false,
	is_ground_content = false,
	selection_box = {
		type = "fixed",
                fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	groups = {dig_immediate=3,way=1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_gravel_footstep", gain=0.5},
		dug = {name="default_gravel_footstep", gain=1.0},
	}),
})
minetest.register_craft({
	output = 'default:desert_sand',
	recipe = {
		{'forest:desert_sand_way', 'forest:desert_sand_way', 'forest:desert_sand_way'},
		{'forest:desert_sand_way', 'forest:desert_sand_way', 'forest:desert_sand_way'},
		{'forest:desert_sand_way', 'forest:desert_sand_way', 'forest:desert_sand_way'},
	}
})
minetest.register_craft({
	output = 'forest:desert_sand_way 9',
	recipe = {
		{'default:desert_sand'},
	}
})
]]--
