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
minetest.register_node("earthbuild:stick_platform", {
	description = "Stick Platform",
	drawtype = "nodebox",
	tiles = { "earthbuild_stick_platform_top.png",
	 					"earthbuild_stick_platform_top.png",
						"earthbuild_stick_platform_side.png",
						"earthbuild_stick_platform_side.png",
						"earthbuild_stick_platform_side.png",
						"earthbuild_stick_platform_side.png"},
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.375, -0.5, 0.5, 0.501, 0.5},
		},
	},
	selection_box = {
		type = "fixed",
        	fixed = {
			{-0.5, 0.375, -0.5, 0.5, 0.501, 0.5},
		},

    },
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 1,},
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_craft({
	output = 'earthbuild:stick_platform 5',
	recipe = {
		{'group:stick', '', 'group:stick'},
		{'', 'group:stick', ''},
		{'group:stick', '', 'group:stick'},
	}
})
minetest.register_craft({
	output = 'default:stick 5',
	recipe = {
		{'earthbuild:stick_platform'}
	}
})
minetest.register_craft({
	type = "fuel",
	recipe = "earthbuild:stick_platform",
	burntime = 1.5,
})

minetest.register_node("earthbuild:stick_platform_with_brush", {
	description = "Stick Platform with Brush",
	drawtype = "nodebox",
	tiles = { "earthbuild_thatch.png", "earthbuild_stick_platform_with_brush.png", "earthbuild_stick_platform_with_brush_side.png", "earthbuild_stick_platform_with_brush_side.png", "earthbuild_stick_platform_with_brush_side.png", "earthbuild_stick_platform_with_brush_side.png"},
	paramtype = "light",
	node_box = {
		type = "fixed",
        	fixed = {
            {-0.5, 0.25, -0.5, 0.5, 0.5, 0.5},
		},
	},
	selection_box = {
		type = "fixed",
        	fixed = {
            {-0.5, 0.25, -0.5, 0.5, 0.5, 0.5},
		},
    },

	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 1,},
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_craft({
	output = 'earthbuild:stick_platform_with_brush 6',
	recipe = {
		{'', 'earthbuild:thatch', ''},
		{'earthbuild:stick_platform', 'earthbuild:stick_platform', 'earthbuild:stick_platform'},
		{'earthbuild:stick_platform', 'earthbuild:stick_platform', 'earthbuild:stick_platform'},
	}
})
minetest.register_craft({
	output = 'earthbuild:stick_platform',
	recipe = {
		{'earthbuild:stick_platform_with_brush'}
	}
})
minetest.register_craft({
	type = "fuel",
	recipe = "earthbuild:stick_platform_with_brush",
	burntime = 3,
})
]]--
