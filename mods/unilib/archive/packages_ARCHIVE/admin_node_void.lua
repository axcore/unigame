---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    maptools
-- Code:    zlib
-- Media:   zlib
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
register_node("maptools:ignore_like", {
	description = S("Ignore-like"),
	inventory_image = "default_steel_block.png^dye_pink.png",
	tiles = {"invisible.png"},
	paramtype = "light",
	sunlight_propagates = true,
})

register_node("maptools:ignore_like_no_clip", {
	description = S("Ignore-like (no clip)"),
	inventory_image = "default_steel_block.png^dye_violet.png",
	tiles = {"invisible.png"},
	paramtype = "light",
	walkable = false,
	sunlight_propagates = true,
})

register_node("maptools:ignore_like_no_point", {
	description = S("Ignore-like (no point)"),
	inventory_image = "default_steel_block.png^dye_violet.png",
	tiles = {"invisible.png"},
	paramtype = "light",
	pointable = false,
	sunlight_propagates = true,
})

register_node("maptools:ignore_like_no_clip_no_point", {
	description = S("Ignore-like (no clip, no point)"),
	inventory_image = "default_steel_block.png^dye_pink.png",
	tiles = {"invisible.png"},
	paramtype = "light",
	walkable = false,
	pointable = false,
	sunlight_propagates = true,
})
]]--
