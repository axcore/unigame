---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    abriglass
-- Code:    MIT
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local oneway_list = {
	{"dark", "Dark", "oneway_face.png", "abriglass_oneway_wall.png",},
	{"pale", "White", "oneway_face.png^[colorize:#F8F8FF:200", "abriglass_oneway_wall.png^[colorize:#E6E6FA:200",},
	{"desert_brick", "Desert Brick", "oneway_face.png^[colorize:#814F3C:200", "default_desert_stone_brick.png",},
	{"stone_brick", "Stone Brick", "oneway_face.png^[colorize:#615E5D:200", "default_stone_brick.png",},
	{"sandstone_brick", "Sandstone Brick", "oneway_face.png^[colorize:#FFF9C5:200", "default_sandstone_brick.png",},
}

for i in ipairs(oneway_list) do
	local name = oneway_list[i][1]
	local description = oneway_list[i][2]
	local image1 = oneway_list[i][3]
	local image2 = oneway_list[i][4]

	minetest.register_node("abriglass:oneway_glass_"..name, {
		description = description.." One-Way Glass",
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
			},
		},
		groups = {cracky = 3},
		tiles = {"abriglass_oneway_plain_glass.png", -- up
				 "abriglass_oneway_plain_glass.png", -- down
				 "abriglass_oneway_plain_glass.png", -- right
				 "abriglass_oneway_plain_glass.png", -- left
				 "abriglass_"..image1, -- back
				 image2, -- front
				 },
		use_texture_alpha = "blend",
		is_ground_content = false,
		sunlight_propagates = true,
		inventory_image = minetest.inventorycube("abriglass_"..image1)
	})
end

local oneway_recipe_list = {
	{"abriglass:oneway_glass_desert_brick", "default:desert_stonebrick",},
	{"abriglass:oneway_glass_stone_brick", "default:stonebrick",},
	{"abriglass:oneway_glass_sandstone_brick", "default:sandstonebrick",},
	{"abriglass:oneway_glass_dark", "abriglass:oneway_wall_dark",},
	{"abriglass:oneway_glass_pale", "abriglass:oneway_wall_pale",},
}

for i in ipairs(oneway_recipe_list) do
	local name = oneway_recipe_list[i][1]
	local ingredient = oneway_recipe_list[i][2]

	minetest.register_craft({
		output = name.." 2",
		recipe = {
			{'abriglass:clear_glass', 'default:mese_crystal_fragment', ingredient },
		}
	})
end
]]--
