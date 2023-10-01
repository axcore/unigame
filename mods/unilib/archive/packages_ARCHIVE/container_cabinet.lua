---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local function register_storage(name, desc, def)
	xdecor.register(name, {
		description = desc,
		inventory = {size = def.inv_size or 24},
		infotext = desc,
		tiles = def.tiles,
		use_texture_alpha = ALPHA_OPAQUE,
		node_box = def.node_box,
		on_rotate = def.on_rotate,
		on_place = def.on_place,
		groups = def.groups or {choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
		sounds = default.node_sound_wood_defaults()
	})
end

register_storage("cabinet", S("Wooden Cabinet"), {
	on_rotate = screwdriver.rotate_simple,
	tiles = {
		"xdecor_cabinet_sides.png", "xdecor_cabinet_sides.png",
		"xdecor_cabinet_sides.png", "xdecor_cabinet_sides.png",
		"xdecor_cabinet_sides.png", "xdecor_cabinet_front.png"
	}
})

register_storage("cabinet_half", S("Half Wooden Cabinet"), {
	inv_size = 8,
	node_box = xdecor.nodebox.slab_y(0.5, 0.5),
	on_rotate = screwdriver.rotate_simple,
	tiles = {
		"xdecor_cabinet_sides.png", "xdecor_cabinet_sides.png",
		"xdecor_half_cabinet_sides.png", "xdecor_half_cabinet_sides.png",
		"xdecor_half_cabinet_sides.png", "xdecor_half_cabinet_front.png"
	}
})

minetest.register_craft({
	output = "xdecor:cabinet",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"doors:trapdoor", "", "doors:trapdoor"},
		{"group:wood", "group:wood", "group:wood"}
	}
})

minetest.register_craft({
	output = "xdecor:cabinet_half 2",
	recipe = {
		{"xdecor:cabinet"}
	}
})
]]--
