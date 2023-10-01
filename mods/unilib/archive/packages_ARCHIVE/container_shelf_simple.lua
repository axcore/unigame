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
minetest.register_node("cottages:shelf", {
        description = S("open storage shelf"),
        drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
        tiles = {"cottages_minimal_wood.png"},
        paramtype = "light",
        paramtype2 = "facedir",
        groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
        node_box = {
            type = "fixed",
            fixed = {

                { -0.5, -0.5, -0.3, -0.4,  0.5,  0.5},
                {  0.4, -0.5, -0.3,  0.5,  0.5,  0.5},

                { -0.5, -0.2, -0.3,  0.5, -0.1,  0.5},
                { -0.5,  0.3, -0.3,  0.5,  0.4,  0.5},
            },
        },
        selection_box = {
            type = "fixed",
            fixed = {
                { -0.5, -0.5, -0.5,  0.5, 0.5,  0.5},
            },
        },

        on_construct = function(pos)

                    local meta = minetest.get_meta(pos);

            local spos = pos.x .. "," .. pos.y .. "," .. pos.z
                    meta:set_string("formspec",
                                "size[8,8]"..
                                "list[current_name;main;0,0;8,3;]"..
                                "list[current_player;main;0,4;8,4;]"..
                "listring[nodemeta:" .. spos .. ";main]" ..
                "listring[current_player;main]")
                    meta:set_string("infotext", S("open storage shelf"))
                    local inv = meta:get_inventory();
                    inv:set_size("main", 24);
            end,

            can_dig = function( pos,player )
                    local  meta = minetest.get_meta( pos );
                    local  inv = meta:get_inventory();
                    return inv:is_empty("main");
            end,

                on_metadata_inventory_put  = function(pos, listname, index, stack, player)
                    local  meta = minetest.get_meta( pos );
                        meta:set_string('infotext', S('open storage shelf (in use)'));
                end,
                on_metadata_inventory_take = function(pos, listname, index, stack, player)
                    local  meta = minetest.get_meta( pos );
                    local  inv = meta:get_inventory();
                    if( inv:is_empty("main")) then
                           meta:set_string('infotext', S('open storage shelf (empty)'));
                        end
                end,
        is_ground_content = false,
})
minetest.register_craft({
    output = "cottages:shelf",
    recipe = {
        {cottages.craftitem_stick,  cottages.craftitem_wood, cottages.craftitem_stick, },
        {cottages.craftitem_stick, cottages.craftitem_wood, cottages.craftitem_stick, },
        {cottages.craftitem_stick, "",             cottages.craftitem_stick}
    }
})
]]--
