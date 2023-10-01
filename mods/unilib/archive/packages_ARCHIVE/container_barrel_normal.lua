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
-- prepare formspec
barrel.on_construct = function( pos )

   local meta = minetest.get_meta(pos);
   local percent = math.random( 1, 100 ); -- TODO: show real filling

   meta:set_string( 'formspec', 
                               "size[8,9]"..
                                "image[2.6,2;2,3;default_sandstone.png^[lowpart:"..
                                                (100-percent)..":default_desert_stone.png]".. -- TODO: better images
                                "label[2.2,0;"..S("Pour:").."]"..
                                "list[current_name;input;3,0.5;1,1;]"..
                                "label[5,3.3;"..S("Fill:").."]"..
                                "list[current_name;output;5,3.8;1,1;]"..
                                "list[current_player;main;0,5;8,4;]");


   meta:set_string( 'liquid_type', '' ); -- which liquid is in the barrel?
   meta:set_int(    'liquid_level', 0 ); -- how much of the liquid is in there?

   local inv = meta:get_inventory()
   inv:set_size("input",     1);  -- to fill in new liquid
   inv:set_size("output",    1);  -- to extract liquid 
end

-- can only be digged if there are no more vessels/buckets in any of the slots
-- TODO: allow digging of a filled barrel? this would disallow stacking of them
barrel.can_dig = function( pos, player )
   local  meta = minetest.get_meta(pos);
   local  inv = meta:get_inventory()

   return ( inv:is_empty('input')
        and inv:is_empty('output'));
end

-- the barrel received input; either a new liquid that is to be poured in or a vessel that is to be filled
barrel.on_metadata_inventory_put = function( pos, listname, index, stack, player )
end

-- right-click to open/close barrel; punch to switch between horizontal/vertical position
minetest.register_node("cottages:barrel", {
        description = S("barrel (closed)"),
        paramtype = "light",
        drawtype = "mesh",
                mesh = "cottages_barrel_closed.obj",
        tiles = {"cottages_barrel.png" },
        groups = { tree = 1, snappy = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2
        },
        drop = "cottages:barrel",
on_punch      = function(pos, node, puncher)
    minetest.add_node(pos, {name = "cottages:barrel_lying", param2 = node.param2})
end,

on_construct = function( pos )
   return barrel.on_construct( pos );
end,
can_dig = function(pos,player)
   return barrel.can_dig( pos, player );
end,
on_metadata_inventory_put = function(pos, listname, index, stack, player)
   return barrel.on_metadata_inventory_put( pos, listname, index, stack, player );
end,
        is_ground_content = false,

})

-- this barrel is opened at the top
minetest.register_node("cottages:barrel_open", {
        description = S("barrel (open)"),
        paramtype = "light",
        drawtype = "mesh",
                mesh = "cottages_barrel.obj",
        tiles = {"cottages_barrel.png" },
        groups = { tree = 1, snappy = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2, not_in_creative_inventory=1,
        },
        drop = "cottages:barrel",
        on_punch      = function(pos, node, puncher)
            minetest.add_node(pos, {name = "cottages:barrel_lying_open", param2 = node.param2})
        end,
        is_ground_content = false,
})

-- horizontal barrel
minetest.register_node("cottages:barrel_lying", {
        description = S("barrel (closed), lying somewhere"),
        paramtype = "light",
                paramtype2 = "facedir",
        drawtype = "mesh",
                mesh = "cottages_barrel_closed_lying.obj",
        tiles = {"cottages_barrel.png" },
        groups = { tree = 1, snappy = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2, not_in_creative_inventory=1,
        },
        drop = "cottages:barrel",
        on_rightclick = function(pos, node, puncher)
            minetest.add_node(pos, {name = "cottages:barrel_lying_open", param2 = node.param2})
        end,
        on_punch      = function(pos, node, puncher)
            if( node.param2 < 4 ) then
               minetest.add_node(pos, {name = "cottages:barrel_lying", param2 = (node.param2+1)})
            else
               minetest.add_node(pos, {name = "cottages:barrel", param2 = 0})
            end
        end,
        is_ground_content = false,
})

-- horizontal barrel, open
minetest.register_node("cottages:barrel_lying_open", {
        description = S("barrel (opened), lying somewhere"),
        paramtype = "light",
                paramtype2 = "facedir",
        drawtype = "mesh",
                mesh = "cottages_barrel_lying.obj",
        tiles = {"cottages_barrel.png" },
        groups = { tree = 1, snappy = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2, not_in_creative_inventory=1,
        },
        drop = "cottages:barrel",
        on_rightclick = function(pos, node, puncher)
            minetest.add_node(pos, {name = "cottages:barrel_lying", param2 = node.param2})
        end,
        on_punch      = function(pos, node, puncher)
            if( node.param2 < 4 ) then
               minetest.add_node(pos, {name = "cottages:barrel_lying_open", param2 = (node.param2+1)})
            else
               minetest.add_node(pos, {name = "cottages:barrel_open", param2 = 0})
            end
        end,
        is_ground_content = false,

})

minetest.register_craft({
    output = "cottages:barrel",
    recipe = {
        {cottages.craftitem_wood,          "",              cottages.craftitem_wood },
        {cottages.craftitem_steel, "",              cottages.craftitem_steel},
        {cottages.craftitem_wood,          cottages.craftitem_wood,    cottages.craftitem_wood },
    },
})
minetest.register_craft({
    output = "cottages:barrel",
    recipe = {
        {"cottages:tub"},
        {"cottages:tub"},
    },
})

minetest.register_craft({
    output = "cottages:tub 2",
    recipe = {
        {"cottages:barrel"},
    },
})
]]--
