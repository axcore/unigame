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
minetest.register_node("darkage:mud", {
	description = "Mud",
	tiles = {"darkage_mud_up.png","darkage_mud.png"},
	is_ground_content = true,
	groups = {crumbly=3},
	drop = 'darkage:mud_lump 4',
	sounds = default.node_sound_dirt_defaults({
		footstep = "",
	}),
})
minetest.register_craft({
	output = "darkage:mud",
	recipe = {
		{"darkage:mud_lump", "darkage:mud_lump"},
		{"darkage:mud_lump", "darkage:mud_lump"},
	}
})
minetest.register_craft({
	output = "darkage:mud 3",
	recipe = {
		{"default:dirt",		"default:dirt"},
		{"default:clay_lump",	"darkage:silt_lump"},
	}
})

minetest.register_craftitem("darkage:mud_lump", {
	description = "Mud Lump",
	inventory_image = "darkage_mud_lump.png",
})
]]--
