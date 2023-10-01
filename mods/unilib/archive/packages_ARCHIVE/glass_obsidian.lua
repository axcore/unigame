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
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("default:obsidian_glass", {
	description = S("Obsidian Glass"),
	drawtype = "glasslike_framed_optional",
	tiles = {"default_obsidian_glass.png", "default_obsidian_glass_detail.png"},
	use_texture_alpha = "clip", -- only needed for stairs API
	paramtype = "light",
	paramtype2 = "glasslikeliquidlevel",
	is_ground_content = false,
	sunlight_propagates = true,
	sounds = default.node_sound_glass_defaults(),
	groups = {cracky = 3},
})
minetest.register_craft({
	type = "cooking",
	output = "default:obsidian_glass",
	recipe = "default:obsidian_shard",
})
local nodes = {
	["trap_obsidian_glass"] = {
		description = S("Trap Obsidian Glass"),
		drawtype = "glasslike_framed_optional",
		tiles = {"default_obsidian_glass.png^moreblocks_trap_box_glass.png", "default_obsidian_glass_detail.png"},
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
	output = "moreblocks:trap_obsidian_glass",
	type = "shapeless",
	recipe = {"default:mese_crystal_fragment", "default:obsidian_glass"},
})

stairs.register_stair(
	"obsidian_glass",
	"default:obsidian_glass",
	{cracky = 3},
	{"stairs_obsidian_glass_split.png", "default_obsidian_glass.png",
	"stairs_obsidian_glass_stairside.png^[transformFX", "stairs_obsidian_glass_stairside.png",
	"default_obsidian_glass.png", "stairs_obsidian_glass_split.png"},
	S("Obsidian Glass Stair"),
	default.node_sound_glass_defaults(),
	false
)

stairs.register_slab(
	"obsidian_glass",
	"default:obsidian_glass",
	{cracky = 3},
	{"default_obsidian_glass.png", "default_obsidian_glass.png", "stairs_obsidian_glass_split.png"},
	S("Obsidian Glass Slab"),
	default.node_sound_glass_defaults(),
	false
)

stairs.register_stair_inner(
	"obsidian_glass",
	"default:obsidian_glass",
	{cracky = 3},
	{"stairs_obsidian_glass_stairside.png^[transformR270", "default_obsidian_glass.png",
	"stairs_obsidian_glass_stairside.png^[transformFX", "default_obsidian_glass.png",
	"default_obsidian_glass.png", "stairs_obsidian_glass_stairside.png"},
	"",
	default.node_sound_glass_defaults(),
	false,
	S("Inner Obsidian Glass Stair")
)

stairs.register_stair_outer(
	"obsidian_glass",
	"default:obsidian_glass",
	{cracky = 3},
	{"stairs_obsidian_glass_stairside.png^[transformR90", "default_obsidian_glass.png",
	"stairs_obsidian_glass_outer_stairside.png", "stairs_obsidian_glass_stairside.png",
	"stairs_obsidian_glass_stairside.png^[transformR90","stairs_obsidian_glass_outer_stairside.png"},
	"",
	default.node_sound_glass_defaults(),
	false,
	S("Outer Obsidian Glass Stair")
)
]]--
