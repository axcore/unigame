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
minetest.register_node("decoblocks:sandstone_arch", {
	description = "Sandstone Arch",
	tiles = {
		"default_sandstone.png",
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1875, 0.4375, -0.5, 0.1875, 0.5, 0.5}, -- NodeBox1
			{-0.5, 0.375, -0.5, -0.1875, 0.5, 0.5}, -- NodeBox2
			{0.1875, 0.375, -0.5, 0.5, 0.5, 0.5}, -- NodeBox3
			{0.25, 0.3125, -0.5, 0.5, 0.375, 0.5}, -- NodeBox4
			{-0.5, 0.3125, -0.5, -0.25, 0.375, 0.5}, -- NodeBox5
			{-0.5, 0.1875, -0.5, -0.3125, 0.3125, 0.5}, -- NodeBox6
			{0.3125, 0.1875, -0.5, 0.5, 0.3125, 0.5}, -- NodeBox7
			{0.375, 0, -0.5, 0.5, 0.1875, 0.5}, -- NodeBox8
			{-0.5, 0, -0.5, -0.375, 0.1875, 0.5}, -- NodeBox9
			{0.4375, -0.5, -0.5, 0.5, 0, 0.5}, -- NodeBox10
			{-0.5, -0.5, -0.5, -0.4375, 0, 0.5}, -- NodeBox11
		}
	},
	groups = {cracky=1}
})

minetest.register_node("decoblocks:sandstone_ledge", {
	description = "Sandstone Ledge",
	tiles = {
		"default_sandstone.png",
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}, -- NodeBox1
			{-0.5, 0.3125, -0.5625, 0.5, 0.5, 0.5}, -- NodeBox2
			{-0.5, 0.4375, -0.625, 0.5, 0.5, 0.5}, -- NodeBox3
		}
	},
	groups = {cracky=1}
})

minetest.register_node("decoblocks:sandstone_ledge_corner", {
	description = "Sandstone Ledge Corner",
	tiles = {
		"default_sandstone.png",
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}, -- NodeBox1
			{-0.5, 0.3125, -0.5625, 0.5625, 0.5, 0.5}, -- NodeBox2
			{-0.5, 0.4375, -0.625, 0.625, 0.5, 0.5}, -- NodeBox3
		}
	},
	groups = {cracky=1}
})

minetest.register_node("decoblocks:sandstone_pillar", {
	description = "Sandstone Pillar",
	tiles = {
	"decoblocks_sandstone_pillar_top.png",
	"decoblocks_sandstone_pillar_top.png",
	"decoblocks_sandstone_pillar.png",
	},
	paramtype2 = "facedir",
	groups = {cracky = 3, stone = 2},
	sounds = default.node_sound_stone_defaults(),
	on_place = minetest.rotate_node
})

minetest.register_node("decoblocks:sandstone_pillar_base", {
	description = "Sandstone Pillar Base",
	tiles = {
	"decoblocks_sandstone_pillar_top.png",
	"decoblocks_sandstone_pillar_top.png",
	"decoblocks_sandstone_pillar.png",
	},
	paramtype2 = "facedir",
	groups = {cracky = 3, stone = 2},
	sounds = default.node_sound_stone_defaults(),
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}, -- NodeBox1
			{-0.5625, -0.5, -0.5625, 0.5625, -0.3125, 0.5625}, -- NodeBox2
			{-0.625, -0.5, -0.625, 0.625, -0.4375, 0.625}, -- NodeBox3
		}
	},
	on_place = minetest.rotate_node
})

minetest.register_node("decoblocks:sandstone_rail", {
	description = "Sandstone Rail",
	tiles = {
		"default_sandstone.png",
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}, -- NodeBox1
			{-0.5, -0.0625, -0.5625, 0.5, 0.125, 0.5}, -- NodeBox2
			{-0.5, 0, -0.625, 0.5, 0.0625, 0.5}, -- NodeBox3
		}
	},
	groups = {cracky=1}
})

minetest.register_node("decoblocks:sandstone_rail_corner", {
	description = "Sandstone Rail Corner",
	tiles = {
		"default_sandstone.png",
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}, -- NodeBox1
			{-0.5625, -0.0625, -0.5625, 0.5, 0.125, 0.5}, -- NodeBox2
			{-0.625, 0, -0.625, 0.5, 0.0625, 0.5}, -- NodeBox3
		}
	},
	groups = {cracky=1}
})

minetest.register_node("decoblocks:painted_sandstone_tile", {
	description = "Painted Sandstone Tile",
	tiles = {
	"default_sandstone.png^decoblocks_floortile.png",
	},
	paramtype2 = "facedir",
	groups = {cracky = 3, stone = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("decoblocks:sandstone_window", {
	description = "Sandstone Window",
	tiles = {
		"default_sandstone.png",
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.25, 0.5}, -- NodeBox1
			{-0.5, 0.25, -0.5, 0.5, 0.5, 0.5}, -- NodeBox2
			{0.25, -0.25, -0.5, 0.5, 0.25, 0.5}, -- NodeBox3
			{-0.5, -0.25, -0.5, -0.25, 0.25, 0.5}, -- NodeBox4
			{0.1875, 0.1875, -0.5, 0.25, 0.25, 0.5}, -- NodeBox5
			{-0.25, 0.1875, -0.5, -0.1875, 0.25, 0.5}, -- NodeBox6
			{-0.375, -0.375, -0.5625, 0.375, -0.25, 0.4375}, -- NodeBox7
			{-0.1875, 0.25, -0.5625, 0.1875, 0.3125, -0.5}, -- NodeBox8
			{-0.25, 0.1875, -0.5625, -0.1875, 0.25, -0.5}, -- NodeBox9
			{0.1875, 0.1875, -0.5625, 0.25, 0.25, -0.5}, -- NodeBox10
		}
	},
	groups = {cracky=1}
})
]]--
