---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plaster
-- Code:    CC BY-SA 3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("plaster:plaster", {
	description = "Plaster",
	tiles = {"plaster_plaster.png"},
	is_ground_content = false,
	groups = {choppy = 2, cracky = 2},
	sounds = default.node_sound_stone_defaults(),
})

local s = "group:sand"
local l = "plaster:lime"
local w = "bucket:bucket_water"

minetest.register_craft({
	output = "plaster:plaster 6",
	recipe = {
		{s,l,s},
		{l, w, l},
		{s, l, s}
	},
	replacements = {
		{w, w},
	}
})
]]--
