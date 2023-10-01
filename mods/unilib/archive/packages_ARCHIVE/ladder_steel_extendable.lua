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
minetest.register_node("ropes:ladder_steel", {
	description = steel_name,
	_doc_items_longdesc = ropes.doc.ladder_longdesc,
	_doc_items_usagehelp = ropes.doc.ladder_usagehelp,
	tiles = {"default_steel_block.png","default_steel_block.png","default_steel_block.png","default_steel_block.png","default_ladder_steel.png"},
	use_texture_alpha = "clip",
	inventory_image = "default_ladder_steel.png",
	wield_image = "default_ladder_steel.png",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	walkable = false,
	climbable = true,
	is_ground_content = false,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, 0.3125, -0.25, 0.5, 0.5}, -- Upright1
			{0.25, -0.5, 0.3125, 0.4375, 0.5, 0.5}, -- Upright2
			{-0.25, 0.3125, 0.375, 0.25, 0.4375, 0.5}, -- Rung_4
			{-0.25, -0.1875, 0.375, 0.25, -0.0625, 0.5}, -- Rung_2
			{-0.25, -0.4375, 0.375, 0.25, -0.3125, 0.5}, -- Rung_1
			{-0.25, 0.0625, 0.375, 0.25, 0.1875, 0.5}, -- Rung_3
		}
	},
	groups = {cracky = 2, flow_through = 1},
	sounds = default.node_sound_metal_defaults(),
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		return ladder_extender(pos, node, clicker, itemstack, pointed_thing, "ropes:ladder_steel", ropes.extending_steel_ladder_limit)
	end,
})
local steel_recipe = {
		{"default:steel_ingot", "", "default:steel_ingot"},
		{"default:steel_ingot", "", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
	}
local steel_name = S("Steel Extendable Ladder")
]]--
