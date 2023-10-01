---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.container_shelf_fancy = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.container_shelf_fancy.init()

    return {
        description = "Fancy wooden shelves",
        depends = "container_box_simple",
    }

end

function unilib.pkg.container_shelf_fancy.exec()

    unilib.register_node("unilib:container_shelf_fancy", "darkage:wood_shelves", mode, {
        -- From darkage:wood_shelves
        description = S("Fancy Wooden Shelves"),
        tiles = {
            "unilib_container_shelf_fancy.png",
            "unilib_container_shelf_fancy.png",
            "unilib_container_shelf_fancy.png",
            "unilib_container_shelf_fancy.png",
            "unilib_container_shelf_fancy.png",
            "unilib_container_shelf_fancy_front.png",
        },
        groups = {snappy = 3},
        sounds = unilib.sound_table.wood,

        paramtype2 = "facedir",

        can_dig = function(pos,player)

            local meta = minetest.get_meta(pos);
            local inv = meta:get_inventory()
            return inv:is_empty("up") and inv:is_empty("down")

        end,

        on_construct = function(pos)

            local meta = minetest.get_meta(pos)
            meta:set_string(
                "formspec",
                "size[8,9]" ..
                "list[context;up;0,0;8,2;]" ..
                "list[context;down;0,2.3;8,2;]" ..
                "list[current_player;main;0,4.85;8,1;]" ..
                "list[current_player;main;0,6.08;8,3;8]" ..
                "listring[context;up]" ..
                "listring[context;down]" ..
                "listring[current_player;main]"
            )
            meta:set_string("infotext", S("Fancy Wooden Shelves"))
            local inv = meta:get_inventory()
            inv:set_size("up", 16)
            inv:set_size("down", 16)

        end,

        on_metadata_inventory_move = function(
            pos, from_list, from_index, to_list, to_index, count, player
        )
            unilib.log(
                "action",
                player:get_player_name() .. " moves stuff in fancy shelves at " ..
                        minetest.pos_to_string(pos)
            )

        end,

        on_metadata_inventory_put = function(pos, listname, index, stack, player)

            unilib.log(
                "action",
                player:get_player_name() .. " moves stuff to fancy shelves at " ..
                        minetest.pos_to_string(pos)
            )

        end,

        on_metadata_inventory_take = function(pos, listname, index, stack, player)

            unilib.log(
                "action",
                player:get_player_name() .. " takes stuff from fancy shelves at " ..
                        minetest.pos_to_string(pos)
            )

        end,
    })
    unilib.register_craft({
        -- From darkage:wood_shelves
        output = "unilib:container_shelf_fancy",
        recipe = {
            {"unilib:container_box_simple"},
            {"unilib:container_box_simple"},
        }
    })

end
