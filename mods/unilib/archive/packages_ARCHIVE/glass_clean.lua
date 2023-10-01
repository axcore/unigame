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
	["clean_glass"] = {
		description = S("Clean Glass"),
		drawtype = "glasslike_framed_optional",
		tiles = {"moreblocks_clean_glass.png", "moreblocks_clean_glass_detail.png"},
		use_texture_alpha = "clip",
		paramtype = "light",
		sunlight_propagates = true,
		is_ground_content = false,
		groups = {cracky = 3, oddly_breakable_by_hand = 3},
		sounds = sound_glass,
	},
}
minetest.register_craft({
	output = "moreblocks:clean_glass",
	type = "shapeless",
	recipe = {"moreblocks:sweeper", "default:glass"},
})
local nodes = {
	["trap_clean_glass"] = {
		description = S("Trap Clean Glass"),
		drawtype = "glasslike_framed_optional",
		tiles = {"moreblocks_clean_glass.png^moreblocks_trap_box_glass.png", "moreblocks_clean_glass_detail.png"},
		use_texture_alpha = "clip",
		paramtype = "light",
		sunlight_propagates = true,
		is_ground_content = false,
		walkable = false,
		groups = {cracky = 3, oddly_breakable_by_hand = 3},
		sounds = sound_glass,
		no_stairs = true,
	},
}
minetest.register_craft({
	output = "moreblocks:trap_clean_glass",
	type = "shapeless",
	recipe = {"default:mese_crystal_fragment", "moreblocks:clean_glass"},
})
minetest.register_craft({
	output = "moreblocks:trap_clean_glass",
	type = "shapeless",
	recipe = {"moreblocks:sweeper", "moreblocks:trap_glass"},
})
]]--
