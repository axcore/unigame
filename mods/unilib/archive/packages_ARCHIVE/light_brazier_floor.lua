---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    castle/castle_lighting
-- Code:    MIT
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local brasier_nodebox = {
	type = "fixed",
	fixed = {
		{-0.25, 0, -0.25, 0.25, 0.125, 0.25}, -- base
		{-0.375, 0.125, -0.375, 0.375, 0.25, 0.375}, -- mid
		{-0.5, 0.25, -0.5, 0.5, 0.375, 0.5}, -- plat
		{-0.5, 0.375, 0.375, 0.5, 0.5, 0.5}, -- edge
		{-0.5, 0.375, -0.5, 0.5, 0.5, -0.375}, -- edge
		{0.375, 0.375, -0.375, 0.5, 0.5, 0.375}, -- edge
		{-0.5, 0.375, -0.375, -0.375, 0.5, 0.375}, -- edge
		{0.25, -0.5, -0.375, 0.375, 0.125, -0.25}, -- leg
		{-0.375, -0.5, 0.25, -0.25, 0.125, 0.375}, -- leg
		{0.25, -0.5, 0.25, 0.375, 0.125, 0.375}, -- leg
		{-0.375, -0.5, -0.375, -0.25, 0.125, -0.25}, -- leg
		{-0.125, -0.0625, -0.125, 0.125, 0, 0.125}, -- bottom_knob
	}
}
local brasier_selection_box = {
	type = "fixed",
	fixed = {
		{-0.375, -0.5, -0.375, 0.375, 0.25, 0.375}, -- mid
		{-0.5, 0.25, -0.5, 0.5, 0.5, 0.5}, -- plat
	}
}

minetest.register_node("castle_lighting:brasier_floor", {
	description = S("Floor Brasier"),
	_doc_items_longdesc = brasier_longdesc,
	_doc_items_usagehelp = brasier_usagehelp,
	tiles = {
		"castle_steel.png^(castle_coal_bed.png^[mask:castle_brasier_bed_mask.png)",
		"castle_steel.png",
		"castle_steel.png",
		"castle_steel.png",
		"castle_steel.png",
		"castle_steel.png",
		},
	drawtype = "nodebox",
	groups = {cracky=2},
	paramtype = "light",
	node_box = brasier_nodebox,
	selection_box = brasier_selection_box,
	
	on_construct = brasier_on_construct,
	on_destruct = brasier_on_destruct,
	can_dig = brasier_can_dig,
	allow_metadata_inventory_put = brasier_allow_metadata_inventory_put,
	on_metadata_inventory_put = brasier_burn,
	on_timer = brasier_burn,
})
minetest.register_craft({
	output = "castle_lighting:brasier_floor",
	recipe = {
		{"default:steel_ingot", "default:torch", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
	}
})
]]--
