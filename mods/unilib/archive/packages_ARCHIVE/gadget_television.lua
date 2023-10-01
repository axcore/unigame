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
xdecor.register("tv", {
	description = S("Television"),
	light_source = 11,
	groups = {cracky = 3, oddly_breakable_by_hand = 2},
	on_rotate = screwdriver.rotate_simple,
	tiles = {
		"xdecor_television_left.png^[transformR270",
		"xdecor_television_left.png^[transformR90",
		"xdecor_television_left.png^[transformFX",
		"xdecor_television_left.png", "xdecor_television_back.png",
		{
			name = "xdecor_television_front_animated.png",
			animation = {type = "vertical_frames", length = 80.0}
		}
	}
})
minetest.register_craft({
	output = "xdecor:tv",
	recipe = {
		{"default:steel_ingot", "default:copper_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "default:glass", "default:steel_ingot"},
		{"default:steel_ingot", "default:copper_ingot", "default:steel_ingot"}
	}
})
]]--
