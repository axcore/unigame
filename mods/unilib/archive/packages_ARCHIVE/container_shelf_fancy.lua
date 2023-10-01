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
local shelves_formspec = \[\[
	size[8,9]
	list[context;up;0,0;8,2;]
	list[context;down;0,2.3;8,2;]

	list[current_player;main;0,4.85;8,1;]
	list[current_player;main;0,6.08;8,3;8]
	listring[context;up]
	listring[context;down]
	listring[current_player;main]
\]\].. darkage.formbg

minetest.register_node("darkage:wood_shelves", {
	description = "Wooden Shelves",
	tiles = { "darkage_shelves.png","darkage_shelves.png","darkage_shelves.png",
			  "darkage_shelves.png","darkage_shelves.png","darkage_shelves_front.png"},
	paramtype2 = "facedir",
	groups = { snappy = 3, not_cuttable=1 },
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", shelves_formspec)
		meta:set_string("infotext", "Wooden Shelves")
		local inv = meta:get_inventory()
		inv:set_size("up", 16)
		inv:set_size("down", 16)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("up") and inv:is_empty("down")
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in shelves at "..minetest.pos_to_string(pos))
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to shelves at "..minetest.pos_to_string(pos))
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from shelves at "..minetest.pos_to_string(pos))
	end,
})
minetest.register_craft({
	output = "darkage:wood_shelves",
	recipe = {
		{"darkage:box"},
		{"darkage:box"},
	}
})
]]--
