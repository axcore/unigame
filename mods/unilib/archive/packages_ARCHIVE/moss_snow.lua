---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    snow
-- Code:    GPL 3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
-- Moss
minetest.register_node("snow:moss", {
	description = "Moss",
	inventory_image = "snow_moss.png",
	tiles = {"snow_moss.png"},
	drawtype = "signlike",
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	selection_box = {
		type = "wallmounted",
	},
	is_ground_content = true,
	groups = {crumbly=3, attached_node=1},
	furnace_burntime = 3,
})
minetest.register_craft({
	output = "snow:moss",
	recipe = {
		{"snow:needles", "snow:needles"},
		{"snow:needles", "snow:needles"},
	},
})
]]--
