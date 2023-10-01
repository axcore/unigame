---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ropes
-- Code:    MIT
-- Media:   unknown (textures), CC0 (sounds)
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("ropes:ladder_wood", {
	description = wood_name,
	_doc_items_longdesc = ropes.doc.ladder_longdesc,
	_doc_items_usagehelp = ropes.doc.ladder_usagehelp,
	tiles = {"default_wood.png","default_wood.png","default_wood.png^[transformR270","default_wood.png^[transformR270","default_ladder_wood.png"},
	use_texture_alpha = "clip",
	inventory_image = "default_ladder_wood.png",
	wield_image = "default_ladder_wood.png",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	walkable = false,
	climbable = true,
	is_ground_content = false,
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, 0.375, -0.25, 0.5, 0.5}, -- Upright1
			{0.25, -0.5, 0.375, 0.375, 0.5, 0.5}, -- Upright2
			{-0.4375, 0.3125, 0.4375, 0.4375, 0.4375, 0.5}, -- Rung_4
			{-0.4375, -0.1875, 0.4375, 0.4375, -0.0625, 0.5}, -- Rung_2
			{-0.4375, -0.4375, 0.4375, 0.4375, -0.3125, 0.5}, -- Rung_1
			{-0.4375, 0.0625, 0.4375, 0.4375, 0.1875, 0.5}, -- Rung_3
		}
	},
	groups = {choppy = 2, oddly_breakable_by_hand = 3, flammable = 2, flow_through = 1},
	sounds = default.node_sound_wood_defaults(),
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		return ladder_extender(pos, node, clicker, itemstack, pointed_thing, "ropes:ladder_wood", ropes.extending_wood_ladder_limit)
	end,
})
local wood_recipe = {
		{"group:stick", "group:stick", "group:stick"},
		{"group:stick", "", "group:stick"},
		{"group:stick", "", "group:stick"},
	}
local wood_name = S("Wooden Extendable Ladder")
]]--
