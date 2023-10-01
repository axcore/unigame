---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("mapgen:crystal", {
	description = "Crystal",
	tiles = {{
		name = "mapgen_crystal_anim.png",
		animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 1.00},
	}},
	use_texture_alpha = "blend",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = 7,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.5, -0.25, 0.25, 0.875, 0.25}, -- NodeBox1
			{-0.1875, -0.5, -0.1875, 0.1875, 1.25, 0.1875}, -- NodeBox2
			{-0.625, -0.5, -0.1875, -0.3125, 0.5, 0.125}, -- NodeBox3
			{0.0625, -0.5, -0.625, 0.375, 0.3125, -0.3125}, -- NodeBox5
			{0.3125, -0.5, 0.3125, 0.5625, 0.5, 0.5625}, -- NodeBox7
			{-0.5625, -0.5, -0.125, -0.375, 0.4375, 0.0625}, -- NodeBox8
			{0.125, -0.5, -0.5625, 0.3125, 0.25, -0.375}, -- NodeBox9
			{0.375, -0.5, 0.375, 0.5, 0.4375, 0.5}, -- NodeBox10
		}
	},
	groups = {cracky=2, dig_immediate=3, flammable=1},
	sounds = default.node_sound_glass_defaults()
})

minetest.register_abm({
	nodenames = {"mapgen:crystal"},
	interval = 5,
	chance = 1,
	action = function(pos, node)
		minetest.add_particle({
			pos = {x=pos.x, y=pos.y+0.5, z=pos.z},
			velocity = {x=0, y=0, z=0},
			acceleration = {x=0, y=0, z=0},
			expirationtime = 5,
			size = 25,
			collisiondetection = false,
			collisionremoval = false,
			vertical = true,
			texture = "mapgen_crystal_glow.png",
			animation = {type = "vertical_frames", aspect_w = 32, aspect_h = 32, length = 1.00},
			glow = 9
		})
	end
})

minetest.register_node("mapgen:crystal_small", {
	description = "Small Crystal",
	tiles = {{
		name = "mapgen_crystal_anim.png",
		animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 1.00},
	}},
	use_texture_alpha = "blend",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = 7,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.5, -0.125, 0.125, 0.375, 0.125}, -- NodeBox3
			{-0.0625, -0.5, -0.0625, 0.0625, 0.4375, 0.0625}, -- NodeBox4
			{0, -0.5, 0.1875, 0.1875, 0.125, 0.375}, -- NodeBox5
			{0.0625, -0.5, 0.25, 0.125, 0.0625, 0.3125}, -- NodeBox6
			{-0.3125, -0.5, -0.375, -0.125, -0.0625, -0.1875}, -- NodeBox7
			{-0.25, -0.5, -0.3125, -0.1875, -0.125, -0.25}, -- NodeBox8
			{0.125, -0.5, -0.3125, 0.375, 0.125, -0.0625}, -- NodeBox9
			{0.1875, -0.5, -0.25, 0.3125, 0.1875, -0.125}, -- NodeBox10
			{-0.375, -0.5, 0.125, -0.1875, -0.1875, 0.3125}, -- NodeBox11
			{-0.3125, -0.5, 0.1875, -0.25, -0.25, 0.25}, -- NodeBox12
		}
	},
	groups = {cracky=2, dig_immediate=3, flammable=1},
	sounds = default.node_sound_glass_defaults()
})

minetest.register_abm({
	nodenames = {"mapgen:crystal_small"},
	interval = 5,
	chance = 1,
	action = function(pos, node)
		minetest.add_particle({
			pos = {x=pos.x, y=pos.y+0.1, z=pos.z},
			velocity = {x=0, y=0, z=0},
			acceleration = {x=0, y=0, z=0},
			expirationtime = 5,
			size = 15,
			collisiondetection = false,
			collisionremoval = false,
			vertical = true,
			texture = "mapgen_crystal_glow.png",
			animation = {type = "vertical_frames", aspect_w = 32, aspect_h = 32, length = 1.00},
			glow = 9
		})
	end
})

minetest.register_node("mapgen:crystal_block", {
	description = "Crystal stone",
	tiles = {{
		name = "mapgen_crystal_stone.png",
		animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 1.00},
	}},
	use_texture_alpha = "blend",
	drawtype = "nodebox",
	paramtype = "light",
	light_source = 7,
	groups = {cracky=2, dig_immediate=3, flammable=1},
	sounds = default.node_sound_glass_defaults()
})

minetest.register_craftitem("mapgen:crystal_shard", {
	description = "Crystal Shard",
	inventory_image = "mapgen_crystal_item.png"
})
minetest.register_craft( {
	output = "mapgen:crystal_shard 4",
	recipe = {
		{ "mapgen:crystal",},
	}
})
minetest.register_craft( {
	output = "mapgen:crystal_shard 2",
	recipe = {
		{ "mapgen:crystal_small",},
	}
})
]]--
