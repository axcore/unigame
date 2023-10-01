---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    moreblocks
-- Code:    zlib
-- Media:   CC BY-SA 3.0 Unported
--
-- From:    vessels
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("default:glass", {
	description = S("Glass"),
	drawtype = "glasslike_framed_optional",
	tiles = {"default_glass.png", "default_glass_detail.png"},
	use_texture_alpha = "clip", -- only needed for stairs API
	paramtype = "light",
	paramtype2 = "glasslikeliquidlevel",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_craft({
	type = "cooking",
	output = "default:glass",
	recipe = "group:sand",
})
minetest.register_craft({
	type = "cooking",
	output = "default:glass",
	recipe = "vessels:glass_fragments",
})
local nodes = {    
	["trap_glass"] = {
		description = S("Trap Glass"),
		drawtype = "glasslike_framed_optional",
		tiles = {"default_glass.png^moreblocks_trap_box_glass.png", "default_glass_detail.png"},
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
	output = "moreblocks:trap_glass",
	type = "shapeless",
	recipe = {"default:mese_crystal_fragment", "default:glass"},
})

-- Glass stair nodes need to be registered individually to utilize specialized textures.

stairs.register_stair(
	"glass",
	"default:glass",
	{cracky = 3, oddly_breakable_by_hand = 3},
	{"stairs_glass_split.png", "default_glass.png",
	"stairs_glass_stairside.png^[transformFX", "stairs_glass_stairside.png",
	"default_glass.png", "stairs_glass_split.png"},
	S("Glass Stair"),
	default.node_sound_glass_defaults(),
	false
)

stairs.register_slab(
	"glass",
	"default:glass",
	{cracky = 3, oddly_breakable_by_hand = 3},
	{"default_glass.png", "default_glass.png", "stairs_glass_split.png"},
	S("Glass Slab"),
	default.node_sound_glass_defaults(),
	false
)

stairs.register_stair_inner(
	"glass",
	"default:glass",
	{cracky = 3, oddly_breakable_by_hand = 3},
	{"stairs_glass_stairside.png^[transformR270", "default_glass.png",
	"stairs_glass_stairside.png^[transformFX", "default_glass.png",
	"default_glass.png", "stairs_glass_stairside.png"},
	"",
	default.node_sound_glass_defaults(),
	false,
	S("Inner Glass Stair")
)

stairs.register_stair_outer(
	"glass",
	"default:glass",
	{cracky = 3, oddly_breakable_by_hand = 3},
	{"stairs_glass_stairside.png^[transformR90", "default_glass.png",
	"stairs_glass_outer_stairside.png", "stairs_glass_stairside.png",
	"stairs_glass_stairside.png^[transformR90","stairs_glass_outer_stairside.png"},
	"",
	default.node_sound_glass_defaults(),
	false,
	S("Outer Glass Stair")
)

minetest.register_craftitem("vessels:glass_fragments", {
	description = S("Glass Fragments"),
	inventory_image = "vessels_glass_fragments.png",
})
]]--
