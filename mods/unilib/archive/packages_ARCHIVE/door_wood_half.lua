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
minetest.register_node("cottages:half_door", {
		description = S("half door"),
		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		tiles = {"cottages_minimal_wood.png"},
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5,  0.4,  0.48, 0.5,  0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5,  0.4,  0.48, 0.5,  0.5},
			},
		},
                on_rightclick = function(pos, node, puncher)
                    local node2 = minetest.get_node( {x=pos.x,y=(pos.y+1),z=pos.z});

                    local param2 = node.param2;
                    if(     param2%4 == 1) then param2 = param2+1; --2;
                    elseif( param2%4 == 2) then param2 = param2-1; --1;
                    elseif( param2%4 == 3) then param2 = param2-3; --0;
                    elseif( param2%4 == 0) then param2 = param2+3; --3;
                    end;
                    minetest.swap_node(pos, {name = "cottages:half_door", param2 = param2})
                    -- if the node above consists of a door of the same type, open it as well
                    -- Note: doors beneath this one are not opened! It is a special feature of these doors that they can be opend partly
                    if( node2 ~= nil and node2.name == node.name and node2.param2==node.param2) then
                       minetest.swap_node( {x=pos.x,y=(pos.y+1),z=pos.z}, {name = "cottages:half_door", param2 = param2})
                    end
                end,
		is_ground_content = false,
})
minetest.register_craft({
	output = "cottages:half_door 2",
	recipe = {
		{"", cottages.craftitem_wood, "" },
		{"", cottages.craftitem_door, "" },
	}
})
-- transform one half door into another
minetest.register_craft({
	output = "cottages:half_door",
	recipe = {
		{"cottages:half_door_inverted" },
	}
})
minetest.register_craft({
	output = "cottages:half_door_inverted",
	recipe = {
		{"cottages:half_door" },
	}
})

minetest.register_node("cottages:half_door_inverted", {
		description = S("half door inverted"),
		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		tiles = {"cottages_minimal_wood.png"},
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5,  0.48, 0.5, -0.4},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5,  0.48, 0.5, -0.4},
			},
		},
                on_rightclick = function(pos, node, puncher)
                    local node2 = minetest.get_node( {x=pos.x,y=(pos.y+1),z=pos.z});

                    local param2 = node.param2;
                    if(     param2%4 == 1) then param2 = param2-1; --0;
                    elseif( param2%4 == 0) then param2 = param2+1; --1;
                    elseif( param2%4 == 2) then param2 = param2+1; --3;
                    elseif( param2%4 == 3) then param2 = param2-1; --2;
                    end;
                    minetest.swap_node(pos, {name = "cottages:half_door_inverted", param2 = param2})
                    -- open upper parts of this door (if there are any)
                    if( node2 ~= nil and node2.name == node.name and node2.param2==node.param2) then
                       minetest.swap_node( {x=pos.x,y=(pos.y+1),z=pos.z}, {name = "cottages:half_door_inverted", param2 = param2})
                    end
                end,
		is_ground_content = false,
})
]]--
