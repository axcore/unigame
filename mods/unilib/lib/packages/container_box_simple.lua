---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.container_box_simple = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.container_box_simple.init()

    return {
        description = "Simple box",
    }

end

function unilib.pkg.container_box_simple.exec()

    unilib.register_node("unilib:container_box_simple", "darkage:box", mode, {
        -- From darkage:box
        description = S("Simple Box"),
        tiles = {
            "unilib_container_box_simple_top.png",
            "unilib_container_box_simple_top.png",
            "unilib_container_box_simple.png",
        },
        groups = {snappy = 3},
        sounds = unilib.sound_table.wood,

        can_dig = function(pos,player)

            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            return inv:is_empty("main")

        end,

        on_construct = function(pos)

            local meta = minetest.get_meta(pos)
            --[[
            meta:set_string(
                "formspec",
                "size[8,9]" ..
                "list[context;main;0,0.3;8,4;]" ..
                "list[current_player;main;0,4.85;8,1;]" ..
                "list[current_player;main;0,6.08;8,3;8]" ..
                "listring[context;main]" ..
                "listring[current_player;main]"
            )
            ]]--
            meta:set_string(
                "formspec",
                "size[8,7]" ..
                "list[context;main;0,0.3;8,4;]" ..
                "list[current_player;main;0,2.85;8,1;]" ..
                "list[current_player;main;0,4.08;8,3;8]" ..
                "listring[context;main]" ..
                "listring[current_player;main]"
            )
            meta:set_string("infotext", S("Simple Box"))
            local inv = meta:get_inventory()
            inv:set_size("main", 16)

        end,

        on_metadata_inventory_move = function(
            pos, from_list, from_index, to_list, to_index, count, player
        )
            unilib.log(
                "action",
                player:get_player_name() .. " moves stuff in simple box at " ..
                        minetest.pos_to_string(pos)
            )

        end,

        on_metadata_inventory_put = function(pos, listname, index, stack, player)

            unilib.log(
                "action",
                player:get_player_name() .. " moves stuff to simple box at " ..
                        minetest.pos_to_string(pos)
            )

        end,

        on_metadata_inventory_take = function(pos, listname, index, stack, player)

            unilib.log(
                "action",
                player:get_player_name() .. " takes stuff from simple box at " ..
                        minetest.pos_to_string(pos)
            )

        end,
    })
    -- (Original code used "default:wood" as the ingredient, but we will permit any kind of wood)
    unilib.register_craft({
        -- From darkage:box
        output = "darkage:box",
        recipe = {
            {"group:wood", "", "group:wood"},
            {"", "", ""},
            {"group:wood", "", "group:wood"},
        }
    })

end
