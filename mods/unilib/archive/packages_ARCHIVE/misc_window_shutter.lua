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
-- propagate shutting/closing of window shutters to window shutters below/above this one
cottages_window_sutter_operate = function( pos, old_node_state_name, new_node_state_name )
   
   local offsets   = {-1,1,-2,2,-3,3};
   local stop_up   = 0;
   local stop_down = 0;

   for i,v in ipairs(offsets) do

      local node = minetest.get_node_or_nil( {x=pos.x, y=(pos.y+v), z=pos.z } );
      if( node and node.name and node.name==old_node_state_name 
        and ( (v > 0 and stop_up   == 0 ) 
           or (v < 0 and stop_down == 0 ))) then

         minetest.swap_node({x=pos.x, y=(pos.y+v), z=pos.z }, {name = new_node_state_name, param2 = node.param2})

      -- found a diffrent node - no need to search further up
      elseif( v > 0 and stop_up   == 0 ) then
         stop_up   = 1; 

      elseif( v < 0 and stop_down == 0 ) then
         stop_down = 1; 
      end
   end
end
minetest.register_craft({
	output = "cottages:window_shutter_open",
	recipe = {
		{cottages.craftitem_wood, "", cottages.craftitem_wood },
	}
})
-- transform opend and closed shutters into each other for convenience
minetest.register_craft({
	output = "cottages:window_shutter_open",
	recipe = {
		{"cottages:window_shutter_closed" },
	}
})
minetest.register_craft({
	output = "cottages:window_shutter_closed",
	recipe = {
		{"cottages:window_shutter_open" },
	}
})

-- window shutters - they cover half a node to each side
minetest.register_node("cottages:window_shutter_open", {
		description = S("opened window shutters"),
		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		tiles = {"cottages_minimal_wood.png"},
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
                -- larger than one node but slightly smaller than a half node so that wallmounted torches pose no problem
		node_box = {
			type = "fixed",
			fixed = {
				{-0.90, -0.5,  0.4, -0.45, 0.5,  0.5},
				{ 0.45, -0.5,  0.4,  0.9, 0.5,  0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.9, -0.5,  0.4,  0.9, 0.5,  0.5},
			},
		},
                on_rightclick = function(pos, node, puncher)
                    minetest.swap_node(pos, {name = "cottages:window_shutter_closed", param2 = node.param2})
                    cottages_window_sutter_operate( pos, "cottages:window_shutter_open", "cottages:window_shutter_closed" );
                end,
		is_ground_content = false,
})

minetest.register_node("cottages:window_shutter_closed", {
		description = S("closed window shutters"),
		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		tiles = {"cottages_minimal_wood.png"},
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,not_in_creative_inventory=1},
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5,  -0.5,  0.4, -0.05, 0.5,  0.5},
				{ 0.05, -0.5,  0.4,  0.5,  0.5,  0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5,  0.4,  0.5, 0.5,  0.5},
			},
		},
                on_rightclick = function(pos, node, puncher)
                    minetest.swap_node(pos, {name = "cottages:window_shutter_open", param2 = node.param2})
                    cottages_window_sutter_operate( pos, "cottages:window_shutter_closed", "cottages:window_shutter_open" );
                end,
		is_ground_content = false,
		drop = "cottages:window_shutter_open",
})

-- open shutters in the morning
minetest.register_abm({
   nodenames = {"cottages:window_shutter_closed"},
   interval = 20, -- change this to 600 if your machine is too slow
   chance = 3, -- not all people wake up at the same time!
   action = function(pos)

        -- at this time, sleeping in a bed is not possible
        if( not(minetest.get_timeofday() < 0.2 or minetest.get_timeofday() > 0.805)) then
           local old_node = minetest.get_node( pos );
           minetest.swap_node(pos, {name = "cottages:window_shutter_open", param2 = old_node.param2})
           cottages_window_sutter_operate( pos, "cottages:window_shutter_closed", "cottages:window_shutter_open" );
       end
   end
})

-- close them at night
minetest.register_abm({
   nodenames = {"cottages:window_shutter_open"},
   interval = 20, -- change this to 600 if your machine is too slow
   chance = 2,
   action = function(pos)

        -- same time at which sleeping is allowed in beds
        if( minetest.get_timeofday() < 0.2 or minetest.get_timeofday() > 0.805) then
           local old_node = minetest.get_node( pos );
           minetest.swap_node(pos, {name = "cottages:window_shutter_closed", param2 = old_node.param2})
           cottages_window_sutter_operate( pos, "cottages:window_shutter_open", "cottages:window_shutter_closed" );
        end
   end
})
]]--
