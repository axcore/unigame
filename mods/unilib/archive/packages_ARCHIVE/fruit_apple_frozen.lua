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
local apple = minetest.registered_nodes["default:apple"]
nodedef = {
	description = "Snow Apple",
	drawtype = "plantlike",
	tiles = {"snow_apple.png"},
	paramtype = "light",
	paramtype2 = "degrotate",
	walkable = false,
	sunlight_propagates = apple.sunlight_propagates,
	selection_box = apple.selection_box,
	groups = apple.groups,
	sounds = apple.sounds,
	drop = apple.drop,
}
nodedef.groups.flammable = 1

minetest.register_node("snow:apple", nodedef)
]]--
