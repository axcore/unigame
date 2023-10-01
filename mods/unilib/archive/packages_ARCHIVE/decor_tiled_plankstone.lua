---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreblocks
-- Code:    zlib
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local nodes = {
	["plankstone"] = {
		description = S("Plankstone"),
		paramtype2 = "facedir",
		place_param2 = 0,
		groups = {cracky = 3},
		is_ground_content = false,
		tiles = tile_tiles("plankstone"),
		sounds = sound_stone,
	},
}
minetest.register_craft({
	output = "moreblocks:plankstone 4",
	recipe = {
		{"group:stone", "group:wood"},
		{"group:wood", "group:stone"},
	}
})
minetest.register_craft({
	output = "moreblocks:plankstone 4",
	recipe = {
		{"group:wood", "group:stone"},
		{"group:stone", "group:wood"},
	}
})
]]--
