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

-- portholes
local port_list = {
	{"wood",}, {"junglewood",},
}

for i in ipairs(port_list) do
	local name = port_list[i][1]

	minetest.register_node("abriglass:porthole_"..name, {
		description = "Porthole",
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
			},
		},
		groups = {choppy = 2, flammable = 2, wood = 1},
		tiles = {"default_"..name.. ".png", -- up
				 "default_"..name.. ".png", -- down
				 "default_"..name.. ".png", -- right
				 "default_"..name.. ".png", -- left
				 "abriglass_porthole_"..name..".png", -- back
				 "abriglass_porthole_"..name..".png", -- front
				 },
		is_ground_content = false,
		sunlight_propagates = true,
		use_texture_alpha = "clip",
	})
end

local port_recipes = {
	{"wood",}, {"junglewood",},
}

for i in ipairs(port_recipes) do
	local name = port_recipes[i][1]

	minetest.register_craft({
		output = "abriglass:porthole_"..name.." 4",
		recipe = {
			{"default:glass", "", "default:glass",},
			{"default:"..name, "", "default:steel_ingot",},
			{"default:glass", "", "default:glass",},
		}
	})
end
]]--
