---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    replacer
-- Code:    GPL-3.0
-- Media:   GPL-3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
function replacer_homedecor_node_is_owned(pos, placer)

    if( not( placer ) or not(pos )) then
        return true;
    end
    local pname = placer:get_player_name();
    if (type( minetest.is_protected ) == "function") then
        local res = minetest.is_protected( pos, pname );
        if( res ) then
            minetest.chat_send_player( pname, "Cannot replace node. It is protected." );
        end
        return res;
    end

        local ownername = false
        if type(IsPlayerNodeOwner) == "function" then                                   -- node_ownership mod
                if HasOwner(pos, placer) then                                           -- returns true if the node is owned
                        if not IsPlayerNodeOwner(pos, pname) then
                                if type(getLastOwner) == "function" then                -- ...is an old version
                                        ownername = getLastOwner(pos)
                                elseif type(GetNodeOwnerName) == "function" then        -- ...is a recent version
                                        ownername = GetNodeOwnerName(pos)
                                else
                                        ownername = "someone"
                                end
                        end
                end

        elseif type(isprotect)=="function" then                                         -- glomie's protection mod
                if not isprotect(5, pos, placer) then
                        ownername = "someone"
                end
        end

        if ownername ~= false then
                minetest.chat_send_player( pname, "Sorry, "..ownername.." owns that spot." )
                return true
        else
                return false
        end
end

-- turn stored pattern string (<node_name> <param1> <param2>) into something readable by human beeings
replacer.human_readable_pattern = function(pattern)
    if(not(pattern)) then
        return "(nothing)"
    end
    -- data is stored in the form "<nodename> <param1> <param2>"
    local parts = string.split(pattern, " ")
    if(not(parts) or #parts < 3) then
        return "(corrupted data)"
    end
    local node_name = parts[1]
    local param2 = parts[3]

    local def = minetest.registered_nodes[ node_name ]
    if(not(def)) then
        return "(unknown node)"
    end
    local text = "'"..tostring(def.description or "- no description -").."'"
    if(not(def.description) or def.description == "") then
        text = "- no description -"
    end
    -- facedir is probably the most commonly used rotation variant
    if( def.paramtype2 == "facedir"
     or def.paramtype2 == "colorfacedir") then
        local axis_names = {"y+ (Ground)", "z+ (North)", "z- (South)",
                    "x+ (East)", "x- (West)", "y- (Sky)"}
        text = text.." Rotated: "..tostring(param2 % 4)..
            " around axis: "..tostring( axis_names[ math.floor( (param2%24) / 4 ) + 1 ])
    -- wallmounted is diffrent
    elseif( def.paramtype2 == "wallmounted"
         or def.paramtype2 == "colorwallmounted") then
        local axis_names = {"y+ (Ground)", "y- (Sky)",
                    "z+ (North)", "z- (South)",
                    "x+ (East)", "x- (West)"}
        text = text.." Mounted at wall: "..tostring( axis_names[ (param2 % 6)+ 1 ])
    end
    return text
end

-- set the replacer to a new pattern
replacer.set_to = function(player_name, pattern, player, itemstack)
    if(not(player_name) or not(player) or not(itemstack)) then
        return itemstack
    end
    -- fallback if nothing is given
    if(not(pattern)) then
        pattern = "default:dirt 0 0"
    end

    local set_to = replacer.human_readable_pattern(pattern)
    -- change the description of the tool so that it's easier to see which replacer (if you
    -- have more than one in your inv) is set to which node
    local meta = itemstack:get_meta()
    -- actually store the new pattern
    meta:set_string("pattern", pattern )

    meta:set_string("description", "Node replacement tool set to:\n"..set_to..
                    "\n["..tostring(pattern).."]")

    minetest.chat_send_player(player_name, "Node replacement tool set to: "..set_to..
                    "["..tostring(pattern).."].")

    replacer.add_to_hist(player_name, pattern)
    return itemstack -- nothing consumed but data changed
end

-- keep a history of stored patterns for each player (not for each replacer);
-- this history is not saved over server shutdown
replacer.add_to_hist = function(player_name, pattern)
    if(not(player_name) or not(pattern) or pattern == "") then
        return
    end
    if(not(replacer.history)) then
        replacer.history = {}
    end
    if(not(replacer.history[ player_name ])) then
        replacer.history[ player_name ] = {}
    end
    local index = table.indexof(replacer.history[ player_name ], pattern)
    -- only add new entries; do not store duplicates
    if(index and index > -1) then
        return
    end
    -- remove the oldest entry
    if(#replacer.history[ player_name ] >= replacer.max_hist_size) then
        table.remove(replacer.history[ player_name ], 1)
    end
    table.insert(replacer.history[ player_name ], pattern)
end

-- show a formspec with a history of stored patterns to select from
replacer.get_formspec = function(player_name, current_pattern, player)
    -- is the player in creative mode?
    local in_creative_mode = (minetest.settings:get_bool("creative_mode")
                or minetest.check_player_privs(player_name, {creative=true}))
    -- count how many blocks of each type the player has in his inventory
    local counted_inv = {}
    if(not(in_creative_mode)) then
        local inv_main = player:get_inventory():get_list("main")
        for i, v in ipairs(inv_main) do
            local stack_name = v:get_name()
            if(not(counted_inv[ stack_name ])) then
                counted_inv[ stack_name ] = 0
            end
            counted_inv[ stack_name ] = counted_inv[ stack_name ] + v:get_count()
        end
    end

    -- find out which mode the player has currently selected
    local current_mode = 1
    if(replacer.user_mode and replacer.user_mode[ player_name ]) then
        current_mode = table.indexof(replacer.mode_names, replacer.user_mode[ player_name ])
        if(current_mode == -1) then
            current_mode = 1
        end
    end

    local formspec = "size[18,10]"..
        "label[6,0;Node Replacement Tool Setup and History]"..
        "button_exit[8,9.4;2,0.8;quit;Exit]"..
        "label[0.2,8.5;Note: Selected mode and history are reset on server restart.\n"..
            "Note: The selected mode is valid for *all* replacers you use. "..
            "The stored pattern is valid for *this particular* replacer only.]"..
        "label[0.2,0.6;Select mode: When replacing (punching, left-click) or "..
            "placing (right-click) a block, ..]"..
        "dropdown[0.2,1.0;17;select_mode;"..
            table.concat(replacer.mode_descriptions, ",")..
            ";"..tostring(current_mode)..";]"..
        "label[0.2,2.1;Click here to set the replacer to a pattern you have stored before:]"..
        "tablecolumns[color;"..
            "text,align=right,tooltip=Amount of nodes of this type left in your inventory:"..
            ";color;text,align=left,tooltip=Stored pattern:]"..
        "table[0.2,2.5;17,6;replacer_history;"
    -- make sure all variables exist and the current entry is stored
    replacer.add_to_hist(player_name, current_pattern)
    local hist_entries = {}
    local selected = 1
    for i, v in ipairs(replacer.history[ player_name ]) do
        if(v == current_pattern) then
            selected = i
        end
        local amount_left = "#00FF00,infinite supply:,#00FF00"
        if(not(in_creative_mode)) then
            -- which item are we looking for?
            local parts = v:split(" ")
            if(not(parts) or #parts<1) then
                parts = {"does not exist"}
            -- TODO: handle this in a more general way
            elseif(parts[1] == "default:dirt_with_grass") then
                parts[1] = "default:dirt"
            end
            if(counted_inv[ parts[1] ]) then
                amount_left = "#00FF00,"..tostring(counted_inv[ parts[1] ]).." available:"..
                    ",#00FF00"
            else
                amount_left = "#FF0000,none left!,#CFCFCF"
            end
        end
        hist_entries[ i ] = tostring(amount_left)..","..
            minetest.formspec_escape(replacer.human_readable_pattern(v).." ["..v.."]")
    end
    return formspec..table.concat(hist_entries, ",")..";"..tostring(selected).."]"
end

-- does node_name match any name from the circular saw?
-- or is it a node from the cnc machine?
-- and if so, which material is it?
-- returns: {created_by_machine, source node name, mod_name, prefix, material, suffix}
--          (the last four form the name of the node)
replacer.identify_shape_and_material = function(full_node_name)
    local parts = full_node_name:split(":")
    if(not(parts) or #parts < 2) then
        return nil
    end
    local mod_name = parts[1]
    local node_name = parts[2]

    -- it might be a full block - or any other drawtype not really covered here
    local def = minetest.registered_nodes[ full_node_name ]
    if(def and def.drawtype and def.drawtype == "normal") then
        return {"normal", full_node_name,
            mod_name, "", node_name, ""}
    end

    -- a wooden fence rail
    local prefix = "fence_rail_"
    if(mod_name == "default" and node_name:sub(1, #prefix) == prefix) then
        local material = node_name:sub(#prefix + 1)
        return {"fence_rail", "default:"..material, "default", prefix, material, ""}
    end
    -- a wooden fence
    prefix = "fence_"
    if(mod_name == "default" and node_name:sub(1, #prefix) == prefix) then
        local material = node_name:sub(#prefix + 1)
        return {"fence", "default:"..material, "default", prefix, material, ""}
    end
    -- gates come in diffrent wood types as well
    prefix = "gate_"
    if(mod_name == "doors" and node_name:sub(1, #prefix) == prefix) then
        local gate_suffixes = {"_open", "_closed"}
        for i, suffix in ipairs(gate_suffixes) do
            if(node_name:sub(-#suffix) == suffix) then
                local material = node_name:sub(#prefix+1, -#suffix-1)
                return {"gate", "default:"..material, "doors", prefix, material, suffix}
            end
        end
    end
    -- a mese post (comes in diffrent wood types)
    prefix = "mese_post_light_"
    if(full_node_name == "default:mese_post_light") then
        return {"mese_post", "default:wood", "default", "mese_post_light_", "", ""}
    elseif(mod_name == "default" and node_name:sub(1, #prefix) == prefix) then
        local material = node_name:sub(#prefix + 1)
        return {"mese_post", "default:"..material, "default", prefix, material, ""}
    end
    -- walls (usually made out of stone)
    if(full_node_name == "walls:cobble") then
        return {"walls", "default:cobble", "walls", "", "cobble", ""}
    elseif(full_node_name == "walls:mossycobble") then
        return {"walls", "default:mossycobble", "walls", "", "mossycobble", ""}
    elseif(full_node_name == "walls:desertcobble") then
        return {"walls", "default:desert_cobble", "walls", "", "desert_cobble", ""}
    end

    -- it might be a regular stair (or similar node) from MinetestGame's stair mod
    if(mod_name == "stairs") then
        -- stair_inner_ and stair_outer_ need to be checked before stair_ is checked
        -- because they are more specific
        local stair_prefixes = {"stair_inner_", "stair_outer_", "stair_", "slab_"}
        for i, prefix in ipairs(stair_prefixes) do
            if(node_name:sub(1,#prefix) == prefix) then
                local material = node_name:sub(#prefix+1)
                return {"stairs", "default:"..material,
                    mod_name, prefix, material, ""}
            end
        end
        return nil
    end

    -- check if we are dealing with a node from the circular saw from moreblocks
    for prefix, suffixes in pairs(replacer.saw_prefixes) do
        -- the prefix matches; does any suffix match?
        if(node_name:sub(1, #prefix) == prefix) then
            for i, suffix in ipairs(suffixes) do
                if(suffix == "" or node_name:sub(-#suffix) == suffix) then
                    local material = node_name:sub(#prefix + 1, -#suffix-1)
                    for m_name, m_parts in pairs(circular_saw.known_nodes) do
                        if(m_parts[2] == material) then
                            return {"circular_saw", m_name,
                                m_parts[1], prefix, material, suffix}
                        end
                    end
                end
            end
            -- no need to check the other prefixes; they won't match either
            return ""
        end
    end

    -- check if we are dealing with a node from the cnc machine
    if(minetest.global_exists("technic_cnc") and technic_cnc.programs) then
        for i, data in ipairs(technic_cnc.programs) do
            if(full_node_name:sub(-#data.suffix-1) == "_"..data.suffix) then
                local source_node = full_node_name:sub(1,-#data.suffix-2)
                local p = source_node:split(":")
                return {"tecnic_cnc", source_node,
                    p[1], "", p[2], "_"..data.suffix}
            end
        end
    end

    -- TODO: pkarcs, mymillworks etc. mods, pillars, castle, ..
    return nil
end


-- try to convert the old node into the desired new node
-- the mode is stored in replacer.user_mode[ player_name ] (fallback: normal)
replacer.get_new_node_data = function(old_node, stored_pattern, player_name)
    if(not(old_node) or not(stored_pattern) or not(old_node.name)) then
        return nil
    end

    -- normal mode of operation: replace material, shape and orientation
    if(not(replacer.user_mode)
      or not(replacer.user_mode[ player_name ])
      or replacer.user_mode[ player_name ] == "normal") then
        return stored_pattern
    end

    -- what type of node does the stored pattern represent? 
    local new_data = replacer.identify_shape_and_material(stored_pattern[1])
    -- if the type of the stored pattern cannot be identified, then abort here
    if(not(new_data)) then
        return nil
    end
    local old_data = replacer.identify_shape_and_material(old_node.name)
    -- if the type of the node that is to be replaced cannot be identified, then abort here
    if(not(old_data)) then
        return nil
    end

    -- replace material, but keep shape and orientation
    if(replacer.user_mode[ player_name ] == "material") then
        -- now try to replace the *material* of the old node while keeping prefix and postfix
        local new_name = old_data[3]..":"..old_data[4]..new_data[5]..old_data[6]
        -- handle some exceptions like mese post light wood and desert_cobble walls
        if(not(minetest.registered_nodes[ new_name ])
          and replacer.node_name_alternatives[ new_name ]) then
            new_name = replacer.node_name_alternatives[ new_name ]
        end
        -- perhaps we need to change the mod name to the new material as well
        if(not(minetest.registered_nodes[ new_name ])) then
            new_name = new_data[3]..":"..old_data[4]..new_data[5]..old_data[6]
        end
        -- if the node still doesn't exist: give up
        if(not(minetest.registered_nodes[ new_name ])) then
            return nil
        end
        -- keep param1 and param2, but change the node name
        return {new_name, old_node.param1, old_node.param2}

    -- replace shape and orientation, but keep material
    elseif(replacer.user_mode[ player_name ] == "shape") then
        -- now try to replace the *material* of the old node while keeping prefix and postfix
        local new_name = new_data[3]..":"..new_data[4]..old_data[5]..new_data[6]
        -- handle some exceptions like mese post light wood and desert_cobble walls
        if(not(minetest.registered_nodes[ new_name ])
          and replacer.node_name_alternatives[ new_name ]) then
            new_name = replacer.node_name_alternatives[ new_name ]
        end
        -- perhaps we need to change the mod name to the new material as well
        if(not(minetest.registered_nodes[ new_name ])) then
            new_name = old_data[3]..":"..new_data[4]..old_data[5]..new_data[6]
        end
        -- if the node still doesn't exist: give up
        if(not(minetest.registered_nodes[ new_name ])) then
            return nil
        end
        -- keep material, but change shape and orientation
        return {new_name, stored_pattern[2], stored_pattern[3]}
    end
end

replacer.replace = function( itemstack, user, pointed_thing, mode )

       if( user == nil or pointed_thing == nil) then
          return nil;
       end
       local name = user:get_player_name();
 
       if( pointed_thing.type ~= "node" ) then
          minetest.chat_send_player( name, "  Error: No node.");
          return nil;
       end

       local pos  = minetest.get_pointed_thing_position( pointed_thing, mode );
       local node = minetest.get_node_or_nil( pos );
       
       if( node == nil ) then

          minetest.chat_send_player( name, "Error: Target node not yet loaded. Please wait a moment for the server to catch up.");
          return nil;
       end


       local meta = itemstack:get_meta()
       local pattern = meta:get_string("pattern")

       -- make sure it is defined
       if(not(pattern) or pattern == "") then
          pattern = "default:dirt 0 0";
       end

       local keys=user:get_player_control();
       if( keys["aux1"]) then
           minetest.show_formspec(name, "replacer:menu", replacer.get_formspec(name, pattern, user))
           return nil
       end

       -- regain information about nodename, param1 and param2
       local daten = pattern:split( " " );
       -- the old format stored only the node name
       if( #daten < 3 ) then
          daten[2] = 0;
          daten[3] = 0;
       end

       -- if someone else owns that node then we can not change it
       if( replacer_homedecor_node_is_owned(pos, user)) then

          return nil;
       end

       local daten = replacer.get_new_node_data(node, daten, name)
       -- nothing to replace
       if(not(daten)) then
          return
       end

       if( node.name and node.name ~= "" and replacer.blacklist[ node.name ]) then
          minetest.chat_send_player( name, "Replacing blocks of the type '"..( node.name or "?" )..
        "' is not allowed on this server. Replacement failed.");
          return nil;
       end

       if( replacer.blacklist[ daten[1] ]) then
          minetest.chat_send_player( name, "Placing blocks of the type '"..( daten[1] or "?" )..
        "' with the replacer is not allowed on this server. Replacement failed.");
          return nil;
       end

       -- do not replace if there is nothing to be done
       if( node.name == daten[1] ) then

          -- the node itshelf remains the same, but the orientation was changed
          if( node.param1 ~= daten[2] or node.param2 ~= daten[3] ) then
             minetest.add_node( pos, { name = node.name, param1 = daten[2], param2 = daten[3] } );
          end

          return nil;
       end

       -- in survival mode, the player has to provide the node he wants to place
       if( not(minetest.settings:get_bool("creative_mode") )
      and not( minetest.check_player_privs( name, {creative=true}))) then
 
          -- players usually don't carry dirt_with_grass around; it's safe to assume normal dirt here
          -- fortunately, dirt and dirt_with_grass does not make use of rotation
          if( daten[1] == "default:dirt_with_grass" ) then
             daten[1] = "default:dirt";
             pattern = "default:dirt 0 0";
          end

          -- does the player carry at least one of the desired nodes with him?
          if( not( user:get_inventory():contains_item("main", daten[1]))) then
 

             minetest.chat_send_player( name, "You have no further '"..( daten[1] or "?" ).."'. Replacement failed.");
             return nil;
          end


          -- give the player the item by simulating digging if possible
          if(   node.name ~= "air" 
            and node.name ~= "ignore") then

             minetest.node_dig( pos, node, user );

             local digged_node = minetest.get_node_or_nil( pos );
             if( not( digged_node ) 
                or digged_node.name == node.name ) then

                -- some nodes - like liquids - cannot be digged. but they are buildable_to and
                -- thus can be replaced
                local node_def = minetest.registered_nodes[node.name]
                if(not(node_def) or not(node_def.buildable_to)) then
                   minetest.chat_send_player( name, "Replacing '"..( node.name or "air" ).."' with '"..( pattern or "?" ).."' failed. Unable to remove old node.");
                   return nil;
                end
             end
            
          end

          -- consume the item
          user:get_inventory():remove_item("main", daten[1].." 1");
       end
       minetest.add_node( pos, { name =  daten[1], param1 = daten[2], param2 = daten[3] } );
       return nil; -- no item shall be removed from inventory
    end
    
minetest.register_tool( "replacer:replacer",
{
    description = "Node replacement tool",
    groups = {}, 
    inventory_image = "replacer_replacer.png",
    wield_image = "",
    wield_scale = {x=1,y=1,z=1},
    stack_max = 1, -- it has to store information - thus only one can be stacked
    liquids_pointable = true, -- it is ok to painit in/with water

    -- the tool_capabilities are of nearly no intrest here
    tool_capabilities = {
        full_punch_interval = 1.0,
        max_drop_level=0,
        groupcaps={
            -- For example:
            fleshy={times={[2]=0.80, [3]=0.40}, maxwear=0.05, maxlevel=1},
            snappy={times={[2]=0.80, [3]=0.40}, maxwear=0.05, maxlevel=1},
            choppy={times={[3]=0.90}, maxwear=0.05, maxlevel=0}
        }
    },

    node_placement_prediction = nil,

    on_place = function(itemstack, placer, pointed_thing)

       if( placer == nil or pointed_thing == nil) then
          return itemstack; -- nothing consumed
       end
       local name = placer:get_player_name();
       --minetest.chat_send_player( name, "You PLACED this on "..minetest.serialize( pointed_thing )..".");

       local keys=placer:get_player_control();
    
       -- just place the stored node if no new one is to be selected
       if( not( keys["sneak"] ) and not( keys["aux1"])) then

          return replacer.replace( itemstack, placer, pointed_thing, 0  ); end

 
       if( pointed_thing.type ~= "node" ) then
          minetest.chat_send_player( name, "  Error: No node selected.");
          return nil;
       end

       local pos  = minetest.get_pointed_thing_position( pointed_thing, false ); -- node under
       local node = minetest.get_node_or_nil( pos );
       
       local pattern = "default:dirt 0 0";
       if( node ~= nil and node.name ) then
          pattern = node.name..' '..node.param1..' '..node.param2;
       end

       return replacer.set_to(name, pattern, placer, itemstack) -- nothing consumed but data changed
    end,
     

    on_use = function(itemstack, user, pointed_thing)

       return replacer.replace( itemstack, user, pointed_thing, false );
    end,
})
minetest.register_craft({
        output = 'replacer:replacer',
        recipe = {
                { 'default:chest', '',              '' },
                { '',              'default:stick', '' },
                { '',              '',              'default:chest' },
        }
})

-- the player has interacted with our formspec
minetest.register_on_player_receive_fields( function(player, formname, fields)
    if(not(formname) or formname ~= "replacer:menu") then
        return false
    end
    local player_name = player:get_player_name()
    -- the player clicked on an entry in the history
    if(fields and fields.replacer_history
       and replacer.history and replacer.history[ player_name ]) then
        -- find out which line it was
        local selected = minetest.explode_table_event(fields.replacer_history)
        if(selected and (selected.type == "CHG" or selected.type == "DLC")
           and selected.row <= #replacer.history[ player_name ]) then
            local itemstack = player:get_wielded_item()
            itemstack = replacer.set_to(player_name,
                replacer.history[ player_name ][ selected.row ],
                player, itemstack)
            player:set_wielded_item(itemstack)
            return true
        end
    end
    -- the player selected a mode
    if(fields and fields.select_mode) then
        local index = table.indexof(replacer.mode_descriptions,
                minetest.formspec_escape(fields.select_mode))
        if(index and index > -1 and replacer.mode_names[ index ]) then
            replacer.user_mode[ player_name ] = replacer.mode_names[ index ]
        end
    end
    return true
end)

-- populate replacer.saw_prefixes
if(minetest.global_exists("circular_saw") and circular_saw.names) then
    -- this is fixed for the saw and does not depend on which actual nodes are
    -- registered for it later on;
    -- we build this table replacer.saw_prefixes for faster lookup because
    -- many shapes share the same prefix
    for i, v in ipairs(circular_saw.names) do
        local prefix = v[1].."_"
        if(not(replacer.saw_prefixes[ prefix ])) then
            replacer.saw_prefixes[ prefix ] = {v[2]}
        else
            table.insert(replacer.saw_prefixes[ prefix ], v[2])
        end
    end
end
]]--
