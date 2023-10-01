---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local box_formspec = \[\[
	size[8,9]
	list[context;main;0,0.3;8,4;]
	list[current_player;main;0,4.85;8,1;]
	list[current_player;main;0,6.08;8,3;8]
	listring[context;main]
	listring[current_player;main]
\]\].. darkage.formbg

minetest.register_node("darkage:box", {
	description = "Box",
	tiles = { "darkage_box_top.png","darkage_box_top.png","darkage_box.png"},
	groups = { snappy = 3, not_cuttable=1 },
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", box_formspec )
		meta:set_string("infotext", "Box")
		local inv = meta:get_inventory()
		inv:set_size("main", 16)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in box at "..minetest.pos_to_string(pos))
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to box at "..minetest.pos_to_string(pos))
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from box at "..minetest.pos_to_string(pos))
	end,
})
minetest.register_craft({
	output = "darkage:box",
	recipe = {
		{"default:wood", "", "default:wood"},
		{"",			 "", ""},
		{"default:wood", "", "default:wood"},
	}
})
]]--
