---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("default:clay", {
	description = S("Clay"),
	tiles = {"default_clay.png"},
	groups = {crumbly = 3},
	drop = "default:clay_lump 4",
	sounds = default.node_sound_dirt_defaults(),
})
minetest.register_craft({
	output = "default:clay",
	recipe = {
		{"default:clay_lump", "default:clay_lump"},
		{"default:clay_lump", "default:clay_lump"},
	}
})

minetest.register_craftitem("default:clay_lump", {
	description = S("Clay Lump"),
	inventory_image = "default_clay_lump.png",
})
minetest.register_craft({
	output = "default:clay_lump 4",
	recipe = {
		{"default:clay"},
	}
})
]]--
