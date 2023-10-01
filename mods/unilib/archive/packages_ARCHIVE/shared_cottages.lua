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
cottages.allow_sit = function( player )
	-- no check possible
	if( not( player.get_player_velocity )) then
		return true;
	end
	local velo = player:get_player_velocity();
	if( not( velo )) then
		return false;
	end
	local max_velo = 0.0001;
	if(   math.abs(velo.x) < max_velo
	  and math.abs(velo.y) < max_velo
	  and math.abs(velo.z) < max_velo ) then
		return true;
	end
	return false;
end

-- hatches rotate around their axis
--  old facedir:  0, 1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12,13,14,15,16,17,18,19,20,21,22,23
new_facedirs = { 10,19, 4,13, 2,18,22,14,20,16, 0,12,11, 3, 7,21, 9,23, 5, 1, 8,15, 6,17};

cottages.register_hatch = function( nodename, description, texture, receipe_item )

	minetest.register_node( nodename, {
		description = S(description), -- not that there are any other...
		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		tiles = { texture }, 
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},

                node_box = {
                        type = "fixed",
                        fixed = {
                                {-0.49, -0.55, -0.49, -0.3, -0.45, 0.45},
                                {0.3, -0.55, -0.3, 0.49, -0.45, 0.45},
                                {0.49, -0.55, -0.49, -0.3, -0.45, -0.3},
                                {-0.075, -0.55, -0.3, 0.075, -0.45, 0.3},
                                {-0.3, -0.55, -0.075, -0.075, -0.45, 0.075},
                                {0.075, -0.55, -0.075, 0.3, -0.45, 0.075},

                                {-0.3, -0.55, 0.3, 0.3, -0.45, 0.45},

				-- hinges
      				{-0.45,-0.530, 0.45, -0.15,-0.470, 0.525}, 
      				{ 0.15,-0.530, 0.45,  0.45,-0.470, 0.525}, 

				-- handle
      				{-0.05,-0.60,-0.35, 0.05,-0.40,-0.45}, 
                        },
                },
                selection_box = {
                        type = "fixed",
                        fixed = {-0.5, -0.55, -0.5, 0.5, -0.45, 0.5},
                },
                on_rightclick = function(pos, node, puncher)

                    minetest.swap_node(pos, {name = node.name, param2 = new_facedirs[ node.param2+1 ]})
                end,
		is_ground_content = false,
		on_place = minetest.rotate_node,
	})

	minetest.register_craft({
		output = nodename,
		recipe = {
			{ '',           '',              receipe_item },
			{ receipe_item, cottages.craftitem_stick, ''           },
			{ '',           '',              ''           },
		}
	})
end

-- further alternate hatch materials: wood, tree, copper_block
cottages.register_hatch( 'cottages:hatch_wood',  'wooden hatch', 'cottages_minimal_wood.png',  cottages.craftitem_slab_wood );
cottages.register_hatch( 'cottages:hatch_steel', 'metal hatch',  'cottages_steel_block.png',   cottages.craftitem_steel );

-- create the three basic roof parts plus receipes for them;
cottages.register_roof = function( name, tiles, basic_material, homedecor_alternative )

   minetest.register_node("cottages:roof_"..name, {
		description = S("Roof "..name),
		drawtype = "nodebox",
		--tiles = {cottages.textures_roof_wood,cottages.texture_roof_sides,cottages.texture_roof_sides,cottages.texture_roof_sides,cottages.texture_roof_sides,cottages.textures_roof_wood},
		tiles = tiles,
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
			},
		},
		is_ground_content = false,
	})

   -- a better roof than the normal stairs; this one is for usage directly on top of walls (it has the form of a stair)
   if( name~="straw" or not(minetest.registered_nodes["stairs:stair_straw"]) or not(cottages.use_farming_straw_stairs)) then
	minetest.register_node("cottages:roof_connector_"..name, {
		description = S("Roof connector "..name),
		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		tiles = tiles,
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
			},
		},
		is_ground_content = false,
	})
   else
	minetest.register_alias("cottages:roof_connector_straw", "stairs:stair_straw")
   end

   -- this one is the slab version of the above roof
   if( name~="straw" or not(minetest.registered_nodes["stairs:slab_straw"]) or not(cottages.use_farming_straw_stairs)) then
	minetest.register_node("cottages:roof_flat_"..name, {
		description = S("Roof (flat) "..name),
		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
                -- this one is from all sides - except from the underside - of the given material
		tiles = { tiles[1], tiles[2], tiles[1], tiles[1], tiles[1], tiles[1] };
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		node_box = {
			type = "fixed",
			fixed = {	
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			},
		},
		is_ground_content = false,
	})
   else
	minetest.register_alias("cottages:roof_flat_straw", "stairs:slab_straw")
   end


   if( not( homedecor_alternative )
       or ( minetest.get_modpath("homedecor") ~= nil )) then

      minetest.register_craft({
	output = "cottages:roof_"..name.." 6",
	recipe = {
		{'', '', basic_material },
		{'', basic_material, '' },
		{basic_material, '', '' }
	}
      })
   end

   -- make those roof parts that use homedecor craftable without that mod
   if( homedecor_alternative ) then
      basic_material = 'cottages:roof_wood';

      minetest.register_craft({
	output = "cottages:roof_"..name.." 3",
	recipe = {
		{homedecor_alternative, '', basic_material },
		{'', basic_material, '' },
		{basic_material, '', '' }
	}
      })
   end


   minetest.register_craft({
	output = "cottages:roof_connector_"..name,
	recipe = {
		{'cottages:roof_'..name },
		{cottages.craftitem_wood },
	}
   })

   minetest.register_craft({
	output = "cottages:roof_flat_"..name..' 2',
	recipe = {
		{'cottages:roof_'..name, 'cottages:roof_'..name },
	}
   })

   -- convert flat roofs back to normal roofs
   minetest.register_craft({
	output = "cottages:roof_"..name,
	recipe = {
	        {"cottages:roof_flat_"..name, "cottages:roof_flat_"..name }
	}
   })

end -- of cottages.register_roof( name, tiles, basic_material )

cottages.sit_on_bench = function( pos, node, clicker, itemstack, pointed_thing )
	if( not( clicker ) or not( default.player_get_animation ) or not( cottages.allow_sit( clicker ))) then
		return;
	end

	local animation = default.player_get_animation( clicker );
	local pname = clicker:get_player_name();

	if( animation and animation.animation=="sit") then
		default.player_attached[pname] = false
		clicker:set_pos({x=pos.x,y=pos.y-0.5,z=pos.z})
		clicker:set_eye_offset({x=0,y=0,z=0}, {x=0,y=0,z=0})
		clicker:set_physics_override(1, 1, 1)
		default.player_set_animation(clicker, "stand", 30)
	else
		-- the bench is not centered; prevent the player from sitting on air
		local p2 = {x=pos.x, y=pos.y, z=pos.z};
		if not( node ) or node.param2 == 0 then
			p2.z = p2.z+0.3;
		elseif node.param2 == 1 then
			p2.x = p2.x+0.3;
		elseif node.param2 == 2 then
			p2.z = p2.z-0.3;
		elseif node.param2 == 3 then
			p2.x = p2.x-0.3;
		end

		clicker:set_eye_offset({x=0,y=-7,z=2}, {x=0,y=0,z=0})
		clicker:set_pos( p2 )
		default.player_set_animation(clicker, "sit", 30)
		clicker:set_physics_override(0, 0, 0)
		default.player_attached[pname] = true
	end
end

cottages.sleep_in_bed = function( pos, node, clicker, itemstack, pointed_thing )
	if( not( clicker ) or not( node ) or not( node.name ) or not( pos ) or not( cottages.allow_sit( clicker))) then
		return;
	end

	local animation = default.player_get_animation( clicker );
	local pname = clicker:get_player_name();

	local p_above = minetest.get_node( {x=pos.x, y=pos.y+1, z=pos.z});
	if( not( p_above) or not( p_above.name ) or p_above.name ~= 'air' ) then
		minetest.chat_send_player( pname, "This place is too narrow for sleeping. At least for you!");
		return;
	end

	local place_name = 'place';
	-- if only one node is present, the player can only sit;
	-- sleeping requires a bed head+foot or two sleeping mats
	local allow_sleep = false;
	local new_animation = 'sit';

	-- let players get back up
	if( animation and animation.animation=="lay" ) then
		default.player_attached[pname] = false
		clicker:set_pos({x=pos.x,y=pos.y-0.5,z=pos.z})
		clicker:set_eye_offset({x=0,y=0,z=0}, {x=0,y=0,z=0})
		clicker:set_physics_override(1, 1, 1)
		default.player_set_animation(clicker, "stand", 30)
		minetest.chat_send_player( pname, 'That was enough sleep for now. You stand up again.');
		return;
	end

	local second_node_pos = {x=pos.x, y=pos.y, z=pos.z};
	-- the node that will contain the head of the player
	local p = {x=pos.x, y=pos.y, z=pos.z};
	-- the player's head is pointing in this direction
	local dir = node.param2;
	-- it would be odd to sleep in half a bed
	if(     node.name=='cottages:bed_head' ) then
		if(     node.param2==0 ) then
			second_node_pos.z = pos.z-1;
		elseif( node.param2==1) then
			second_node_pos.x = pos.x-1;
		elseif( node.param2==2) then
			second_node_pos.z = pos.z+1;
		elseif( node.param2==3) then
			second_node_pos.x = pos.x+1;
		end
		local node2 = minetest.get_node( second_node_pos );
		if( not( node2 ) or not( node2.param2 ) or not( node.param2 )
		   or node2.name   ~= 'cottages:bed_foot'
		   or node2.param2 ~= node.param2 ) then
			allow_sleep = false;
		else
			allow_sleep = true;
		end
		place_name = 'bed';

	-- if the player clicked on the foot of the bed, locate the head
	elseif( node.name=='cottages:bed_foot' ) then
		if(     node.param2==2 ) then
			second_node_pos.z = pos.z-1;
		elseif( node.param2==3) then
			second_node_pos.x = pos.x-1;
		elseif( node.param2==0) then
			second_node_pos.z = pos.z+1;
		elseif( node.param2==1) then
			second_node_pos.x = pos.x+1;
		end
		local node2 = minetest.get_node( second_node_pos );
		if( not( node2 ) or not( node2.param2 ) or not( node.param2 )
		   or node2.name   ~= 'cottages:bed_head'
		   or node2.param2 ~= node.param2 ) then
			allow_sleep = false;
		else
			allow_sleep = true;
		end
		if( allow_sleep==true ) then
			p = {x=second_node_pos.x, y=second_node_pos.y, z=second_node_pos.z};
		end
		place_name = 'bed';

	elseif( node.name=='cottages:sleeping_mat' or node.name=='cottages:straw_mat' or node.name=='cottages:sleeping_mat_head') then
		place_name = 'mat';
		dir = node.param2;
		allow_sleep = false;
		-- search for a second mat right next to this one
		local offset = {{x=0,z=-1}, {x=-1,z=0}, {x=0,z=1}, {x=1,z=0}};
		for i,off in ipairs( offset ) do
			node2 = minetest.get_node( {x=pos.x+off.x, y=pos.y, z=pos.z+off.z} );
			if( node2.name == 'cottages:sleeping_mat' or node2.name=='cottages:straw_mat' or node.name=='cottages:sleeping_mat_head' ) then
				-- if a second mat is found, sleeping is possible
				allow_sleep = true;
				dir = i-1;
			end
		end
	end

	-- set the right height for the bed
	if( place_name=='bed' ) then
		p.y = p.y+0.4;
	end
	if( allow_sleep==true ) then
		-- set the right position (middle of the bed)
		if(     dir==0 ) then
			p.z = p.z-0.5;
		elseif( dir==1 ) then
			p.x = p.x-0.5;
		elseif( dir==2 ) then
			p.z = p.z+0.5;
		elseif( dir==3 ) then
			p.x = p.x+0.5;
		end
	end
	
	if( default.player_attached[pname] and animation.animation=="sit") then
		-- just changing the animation...
		if( allow_sleep==true ) then
			default.player_set_animation(clicker, "lay", 30)
			clicker:set_eye_offset({x=0,y=-14,z=2}, {x=0,y=0,z=0})
			minetest.chat_send_player( pname, 'You lie down and take a nap. A right-click will wake you up.');
			return;
		-- no sleeping on this place
		else
			default.player_attached[pname] = false
			clicker:set_pos({x=pos.x,y=pos.y-0.5,z=pos.z})
			clicker:set_eye_offset({x=0,y=0,z=0}, {x=0,y=0,z=0})
			clicker:set_physics_override(1, 1, 1)
			default.player_set_animation(clicker, "stand", 30)
			minetest.chat_send_player( pname, 'That was enough sitting around for now. You stand up again.');
			return;
		end
	end

	clicker:set_eye_offset({x=0,y=-7,z=2}, {x=0,y=0,z=0})
	clicker:set_pos( p );
	default.player_set_animation(clicker, new_animation, 30)
	clicker:set_physics_override(0, 0, 0)
	default.player_attached[pname] = true

	if( allow_sleep==true) then
		minetest.chat_send_player( pname, 'Aaah! What a comftable '..place_name..'. A second right-click will let you sleep.');
	else
		minetest.chat_send_player( pname, 'Comftable, but not good enough for a nap. Right-click again if you want to get back up.');
	end
end

--- if no owner is set, all players may use the node; else only the owner
cottages.player_can_use = function( meta, player )
	if( not( player) or not( meta )) then
		return false;
	end
	local pname = player:get_player_name();
	local owner = meta:get_string('owner' );
	local public = meta:get_string('public')
	if( not(owner) or owner=="" or owner==pname or public=="public") then
		return true;
	end
	return false;
end


-- call this in on_receive_fields and add suitable buttons in order
-- to switch between public and private use
cottages.switch_public = function(pos, formname, fields, sender, name_of_the_thing)
	-- switch between public and private
	local meta = minetest.get_meta(pos)
	local public = meta:get_string("public")
	local owner = meta:get_string("owner")
	if( sender and sender:get_player_name() == owner and fields.public) then
		if( public ~= "public") then
			meta:set_string("public", "public")
			meta:set_string("infotext",
				S("Public "..name_of_the_thing.." (owned by %s)"):format(owner))
			minetest.chat_send_player(owner,
				S("Your "..name_of_the_thing.." can now be used by other players as well."))
		else
			meta:set_string("public", "")
			meta:set_string("infotext",
				S("Private "..name_of_the_thing.." (owned by %s)"):format(owner))
			minetest.chat_send_player(owner,
				S("Your "..name_of_the_thing.." can only be used by yourself."))
		end
		return true
	end
end
]]--
