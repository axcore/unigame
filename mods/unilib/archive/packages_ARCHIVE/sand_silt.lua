---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("darkage:silt", {
	description = "Silt",
	tiles = {"darkage_silt.png"},
	is_ground_content = true,
	groups = {crumbly=3},
	drop = 'darkage:silt_lump 4',
	sounds = default.node_sound_dirt_defaults({
		footstep = "",
	}),
})
minetest.register_craft({
	output = "darkage:silt",
	recipe = {
		{"darkage:silt_lump", "darkage:silt_lump"},
		{"darkage:silt_lump", "darkage:silt_lump"},
	}
})
minetest.register_craft({
	output = "darkage:silt 3",
	recipe = {
		{"default:sand",		"default:sand"},
		{"default:clay_lump",	"default:clay_lump"},
	}
})

minetest.register_craftitem("darkage:silt_lump", {
	description = "Silt Lump",
	inventory_image = "darkage_silt_lump.png",
})
]]--
