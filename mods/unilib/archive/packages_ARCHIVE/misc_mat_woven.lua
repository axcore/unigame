---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    earthbuild
-- Code:    GPLv3
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("earthbuild:woven_mat", {
	description = "Woven Mat",
	drawtype = "nodebox",
	tiles = {"earthbuild_woven_mat.png"},
	paramtype = "light",
	node_box = {
		type = "fixed",
        	fixed = {
			{-0.5, -0.5, -0.5,  0.5, -0.48, 0.5},
		},
	},
	selection_box = {
		type = "fixed",
        	fixed = {
            {-0.5, -0.5, -0.5,  0.5, -0.48, 0.5},
		},
    },

	groups = {snappy=3, flammable = 3,},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_craft({
	output = 'earthbuild:woven_mat',
	recipe = {
		{'', '', ''},
		{'', '', ''},
		{'group:leaves', 'group:leaves', 'group:leaves'},
	}
})
minetest.register_craft({
	output = 'earthbuild:woven_mat',
	recipe = {
		{'', '', ''},
		{'', '', ''},
		{'default:junglegrass', 'default:junglegrass', 'default:junglegrass'},
	}
})
minetest.register_craft({
	output = 'earthbuild:woven_mat',
	recipe = {
		{'', '', ''},
		{'', '', ''},
		{'group:grass', 'group:grass', 'group:grass'},
	}
})
minetest.register_craft({
	output = 'earthbuild:woven_mat',
	recipe = {
		{'', '', ''},
		{'', '', ''},
		{'group:dry_grass', 'group:dry_grass', 'group:dry_grass'},
	}
})
minetest.register_craft({
	type = "fuel",
	recipe = "earthbuild:woven_mat",
	burntime = 1,
})
]]--
