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
minetest.register_node("decoblocks:ancient_vase", {
	description = "Ancient Vase",
	drawtype = "mesh",
	mesh = "vase.obj",
	tiles = {
		"Ancient_vase.png",
	},
	use_texture_alpha = "clip",
	visual_scale = 0.5,
	wield_scale = {x=0.5, y=0.5, z=0.5},
	paramtype = "light",
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	collision_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("decoblocks:vase", {
	description = "Vase",
	drawtype = "mesh",
	mesh = "vase.obj",
	tiles = {
		"vase.png",
	},
	use_texture_alpha = "clip",
	visual_scale = 0.5,
	wield_scale = {x=0.5, y=0.5, z=0.5},
	paramtype = "light",
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	collision_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	groups = {cracky = 2, oddly_breakable_by_hand = 1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = 'decoblocks:vase',
	recipe = {
		{'default:clay_brick', '', 'default:clay_brick'},
		{'default:clay_brick', '', 'default:clay_brick'},
		{'', 'default:clay_brick', ''},
	}
})

minetest.register_node("decoblocks:ancient_vase_sand", {
	description = "Sandstone Vase",
	drawtype = "mesh",
	mesh = "vase.obj",
	tiles = {
		"Ancient_vase_sand.png",
	},
	use_texture_alpha = "clip",
	visual_scale = 0.5,
	wield_scale = {x=0.5, y=0.5, z=0.5},
	paramtype = "light",
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	collision_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})
]]--
