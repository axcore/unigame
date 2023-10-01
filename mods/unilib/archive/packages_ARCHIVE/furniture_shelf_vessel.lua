---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    vessels
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local nodes = {
	["empty_shelf"] = {
		description = S("Empty Shelf"),
		paramtype2 = "facedir",
		tiles = {"default_wood.png", "default_wood.png", "default_wood.png",
		"default_wood.png", "moreblocks_empty_shelf.png", "moreblocks_empty_shelf.png"},
		groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
		is_ground_content = false,
		sounds = sound_wood,
		furnace_burntime = 15,
		no_stairs = true,
	},
}
minetest.register_craft({
	output = "moreblocks:empty_shelf",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"", "", ""},
		{"group:wood", "group:wood", "group:wood"},
	}
})
minetest.register_craft({
	type = "shapeless",
	output = "default:bookshelf",
	recipe = {"moreblocks:empty_shelf", "default:book", "default:book", "default:book"},
})
minetest.register_craft({
	output = "moreblocks:empty_shelf",
	type = "shapeless",
	recipe = {"moreblocks:sweeper", "default:bookshelf"},
	replacements = {{"default:bookshelf", "default:book 3"}},
	-- When obtaining an empty shelf, return the books used in it as well
})
minetest.register_craft({
	output = "moreblocks:empty_shelf",
	type = "shapeless",
	recipe = {"moreblocks:sweeper", "vessels:shelf"},
	replacements = {{"vessels:shelf", "vessels:glass_bottle 3"}},
})
]]--

