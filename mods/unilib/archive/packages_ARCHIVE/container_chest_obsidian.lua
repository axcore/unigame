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
xdecor.register("enderchest", {
	description = S("Ender Chest"),
	tiles = {
		"xdecor_enderchest_top.png", "xdecor_enderchest_top.png",
		"xdecor_enderchest_side.png", "xdecor_enderchest_side.png",
		"xdecor_enderchest_side.png", "xdecor_enderchest_front.png"
	},
	groups = {cracky = 1, choppy = 1},
	sounds = default.node_sound_stone_defaults(),
	on_rotate = screwdriver.rotate_simple,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", -- size[8,9]
				list[current_player;enderchest;0,0;8,4;]
				list[current_player;main;0,5;8,4;]
				listring[current_player;enderchest]
				listring[current_player;main] --
				 .. xbg .. default.get_hotbar_bg(0,5))

		meta:set_string("infotext", S("Ender Chest"))
	end
})
minetest.register_craft({
	output = "xdecor:enderchest",
	recipe = {
		{"", "default:obsidian", ""},
		{"default:obsidian", "default:chest", "default:obsidian"},
		{"", "default:obsidian", ""}
	}
})

minetest.register_on_joinplayer(function(player)
	local inv = player:get_inventory()
	inv:set_size("enderchest", 8*4)
end)
]]--
