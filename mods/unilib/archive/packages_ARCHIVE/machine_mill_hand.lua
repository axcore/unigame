---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cottages
-- Code:    GPLv3
-- Media:   CC/CC-by-SA/WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local cottages_handmill_formspec = "size[8,8]"..
				"image[0,1;1,1;"..cottages.texture_wheat_seed.."]"..
				"button_exit[6.0,0.0;1.5,0.5;public;"..S("Public?").."]"..
                                "list[current_name;seeds;1,1;1,1;]"..
                                "list[current_name;flour;5,1;2,2;]"..
					"label[0,0.5;"..S("Wheat seeds:").."]"..
					"label[4,0.5;"..S("Flour:").."]"..
					"label[0,-0.3;"..S("Mill").."]"..
					"label[0,2.5;"..S("Punch this hand-driven mill").."]"..
					"label[0,3.0;"..S("to convert wheat seeds into flour.").."]"..
                                "list[current_player;main;0,4;8,4;]";

minetest.register_node("cottages:handmill", {
	description = S("mill, powered by punching"),
	drawtype = "mesh",
	mesh = "cottages_handmill.obj",
	tiles = {"cottages_stone.png"},
	paramtype  = "light",
	paramtype2 = "facedir",
	groups = {cracky=2},
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {
					{-0.50, -0.5,-0.50, 0.50,  0.25, 0.50},
			}
	},
	collision_box = {
		type = "fixed",
		fixed = {
					{-0.50, -0.5,-0.50, 0.50,  0.25, 0.50},
			}
	},
	on_construct = function(pos)
               	local meta = minetest.get_meta(pos);
		meta:set_string("infotext", S("Public mill, powered by punching"));
               	local inv = meta:get_inventory();
               	inv:set_size("seeds", 1);
               	inv:set_size("flour", 4);
                meta:set_string("formspec", cottages_handmill_formspec );
		meta:set_string("public", "public")
       	end,

	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos);
		meta:set_string("owner", placer:get_player_name() or "");
		meta:set_string("infotext", S("Private mill, powered by punching (owned by %s)"):format(meta:get_string("owner") or ""));
		meta:set_string("formspec",
				cottages_handmill_formspec..
				"label[2.5,-0.5;"..S("Owner: %s"):format(meta:get_string('owner') or "").."]" );
		meta:set_string("public", "private")
        end,

	on_receive_fields = function(pos, formname, fields, sender)
		cottages.switch_public(pos, formname, fields, sender, 'mill, powered by punching')
	end,

        can_dig = function(pos,player)

                local meta  = minetest.get_meta(pos);
                local inv   = meta:get_inventory();
		local owner = meta:get_string('owner');

                if(  not( inv:is_empty("flour"))
		  or not( inv:is_empty("seeds"))
		  or not( player )
		  or ( owner and owner ~= ''  and player:get_player_name() ~= owner )) then

		   return false;
		end
                return true;
        end,

	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		if( not( cottages.player_can_use( meta, player ))) then
                        return 0
		end
		return count;
	end,

	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		-- only accept input the threshing floor can use/process
		if(    listname=='flour'
		    or (listname=='seeds' and stack and not( cottages.handmill_product[ stack:get_name()] ))) then
			return 0;
		end

		if( not( cottages.player_can_use( meta, player ))) then
                        return 0
		end
		return stack:get_count()
	end,

	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if( not( cottages.player_can_use( meta, player ))) then
                        return 0
		end
		return stack:get_count()
	end,

        -- this code is very similar to the threshing floor; except that it has only one input- and output-slot
 	-- and does not require the usage of a stick
	on_punch = function(pos, node, puncher)
		if( not( pos ) or not( node ) or not( puncher )) then
			return;
		end
		local name = puncher:get_player_name();

               	local meta = minetest.get_meta(pos);
               	local inv = meta:get_inventory();

		local input = inv:get_list('seeds');
		local stack1 = inv:get_stack( 'seeds', 1);

		if(       (      stack1:is_empty())
			or( not( stack1:is_empty())
			     and not( cottages.handmill_product[ stack1:get_name() ] ))) then

			if not( stack1:is_empty() ) then
				minetest.chat_send_player(name,"Nothing happens...")
			end
			-- update the formspec
			meta:set_string("formspec",
				cottages_handmill_formspec..
				"label[2.5,-0.5;"..S("Owner: %s"):format(meta:get_string('owner') or "").."]" );
			return;
		end

		-- turning the mill is a slow process; 1-21 flour are generated per turn
		local anz = 1 + math.random( cottages.handmill_min_per_turn, cottages.handmill_max_per_turn );
		-- we already made sure there is only wheat inside
		local found = stack1:get_count();
		
		-- do not process more wheat than present in the input slots
		if( found < anz ) then
			anz = found;
		end

		local product_stack = ItemStack( cottages.handmill_product[ stack1:get_name() ]);
		local anz_result = anz;
		-- items that produce more
		if( product_stack:get_count()> 1 ) then
			anz_result = anz * product_stack:get_count();
		end

		if(    inv:room_for_item('flour', product_stack:get_name()..' '..tostring( anz_result ))) then

			inv:add_item(    'flour', product_stack:get_name()..' '..tostring( anz_result ));
			inv:remove_item( 'seeds', stack1:get_name()..' '..tostring( anz ));

			local anz_left = found - anz;
			if( anz_left > 0 ) then
				minetest.chat_send_player( name, S('You have ground a %s (%s are left).'):format(stack1:get_definition().description,(anz_left)));
			else
				minetest.chat_send_player( name, S('You have ground the last %s.'):format(stack1:get_definition().description));
			end

			-- if the version of MT is recent enough, rotate the mill a bit
			if( minetest.swap_node ) then
				node.param2 = node.param2 + 1;
				if( node.param2 > 3 ) then
					node.param2 = 0;
				end
				minetest.swap_node( pos, node );
			end
		end	
	end,
})
minetest.register_craft({
	output = "cottages:handmill",
	recipe = {
		{cottages.craftitem_stick,     cottages.craftitem_stone,    "", },
		{"",               cottages.craftitem_steel, "", },
		{"",                  cottages.craftitem_stone,    "", },
	},
})
]]--
