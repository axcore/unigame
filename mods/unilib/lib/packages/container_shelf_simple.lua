---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cottages
-- Code:    GPLv3
-- Media:   CC/CC-by-SA/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.container_shelf_simple = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cottages.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.container_shelf_simple.init()

    return {
        description = "Simple wooden shelves",
    }

end

function unilib.pkg.container_shelf_simple.exec()

    unilib.register_node("unilib:container_shelf_simple", "cottages:shelf", mode, {
        -- From cottages:shelf
        description = S("Simple Wooden Shelves"),
        tiles = {"unilib_misc_wood_rustic.png"},
        groups = {choppy = 2, oddly_breakable_by_hand = 2, snappy = 2},
        -- N.B. no sounds in original code
        sounds = unilib.sound_table.wood,

        drawtype = "nodebox",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.3, -0.4, 0.5, 0.5},
                {0.4, -0.5, -0.3, 0.5, 0.5, 0.5},
                {-0.5, -0.2, -0.3, 0.5, -0.1, 0.5},
                {-0.5, 0.3, -0.3, 0.5, 0.4, 0.5},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            },
        },

        can_dig = function(pos, player)

            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            return inv:is_empty("main")

        end,

        on_construct = function(pos)

            local meta = minetest.get_meta(pos)

            local spos = pos.x .. "," .. pos.y .. "," .. pos.z
            meta:set_string(
                "formspec",
                "size[8,8]" ..
                "list[current_name;main;0,0;8,3;]" ..
                "list[current_player;main;0,4;8,4;]" ..
                "listring[nodemeta:" .. spos .. ";main]" ..
                "listring[current_player;main]"
            )
            meta:set_string("infotext", S("Simple Wooden Shelves"))
            local inv = meta:get_inventory()
            inv:set_size("main", 24)

        end,

        on_metadata_inventory_move = function(
            pos, from_list, from_index, to_list, to_index, count, player
        )
            -- N.B. This callback and its log message not in original code
            unilib.log(
                "action",
                player:get_player_name() .. " moves stuff in simple shelf at " ..
                        minetest.pos_to_string(pos)
            )

        end,

        on_metadata_inventory_put = function(pos, listname, index, stack, player)

            local meta = minetest.get_meta(pos)
            meta:set_string('infotext', unilib.brackets(S("Simple Wooden Shelves"), S("In Use")))

            -- N.B. Log message not in original code
            unilib.log(
                "action",
                player:get_player_name() .. " moves stuff to simple shelf at " ..
                        minetest.pos_to_string(pos)
            )

        end,

        on_metadata_inventory_take = function(pos, listname, index, stack, player)

            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            if inv:is_empty("main") then
                meta:set_string('infotext', unilib.brackets(S("Simple Wooden Shelves"), S("Empty")))
            end

            -- N.B. Log message not in original code
            unilib.log(
                "action",
                player:get_player_name() .. " takes stuff from simple shelf at " ..
                        minetest.pos_to_string(pos)
            )

        end,
    })
    unilib.register_craft({
        -- From cottages:shelf
        output = "unilib:container_shelf_simple",
        recipe = {
            {"group:stick", "group:wood", "group:stick"},
            {"group:stick", "group:wood", "group:stick"},
            {"group:stick", "", "group:stick"}
        }
    })

end
