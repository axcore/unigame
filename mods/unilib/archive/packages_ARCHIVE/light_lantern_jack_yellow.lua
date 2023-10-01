---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("farming:jackolantern", {
	description = S("Jack 'O Lantern (punch to turn on and off)"),
	tiles = {
		"farming_pumpkin_top.png", "farming_pumpkin_top.png",
		"farming_pumpkin_side.png", "farming_pumpkin_side.png",
		"farming_pumpkin_side.png", "farming_pumpkin_face_off.png"
	},
	paramtype2 = "facedir",
	groups = {choppy = 1, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	on_punch = function(pos, node, puncher)
		local name = puncher:get_player_name() or ""
		if minetest.is_protected(pos, name) then return end
		node.name = "farming:jackolantern_on"
		minetest.swap_node(pos, node)
	end
})
minetest.register_craft({
	output = "farming:jackolantern",
	recipe = {
		{"default:torch"},
		{"group:food_pumpkin"}
	}
})

minetest.register_node("farming:jackolantern_on", {
	tiles = {
		"farming_pumpkin_top.png", "farming_pumpkin_top.png",
		"farming_pumpkin_side.png", "farming_pumpkin_side.png",
		"farming_pumpkin_side.png", "farming_pumpkin_face_on.png"
	},
	light_source = default.LIGHT_MAX - 1,
	paramtype2 = "facedir",
	groups = {
		choppy = 1, oddly_breakable_by_hand = 1, flammable = 2,
		not_in_creative_inventory = 1
	},
	sounds = default.node_sound_wood_defaults(),
	drop = "farming:jackolantern",
	on_punch = function(pos, node, puncher)
		local name = puncher:get_player_name() or ""
		if minetest.is_protected(pos, name) then return end
		node.name = "farming:jackolantern"
		minetest.swap_node(pos, node)
	end
})
]]--
