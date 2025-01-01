---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.container_box_simple = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.container_box_simple.init()

    return {
        description = "Simple box",
    }

end

function unilib.pkg.container_box_simple.exec()

    local def_table = {
        description = S("Simple Box"),
        tiles = {
            "unilib_container_box_simple_top.png",
            "unilib_container_box_simple_top.png",
            "unilib_container_box_simple.png",
        },
        groups = {snappy = 3},
        sounds = unilib.global.sound_table.wood,

        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,

        can_dig = function(pos,player)

            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()
            return inv:is_empty("main")

        end,

        -- N.B. No .on_blast() in original code
        on_blast = function(pos)

            local drops = {}
            unilib.misc.get_inventory_drops(pos, "main", drops)
            drops[#drops + 1] = full_name
            core.remove_node(pos)
            return drops

        end,

        on_construct = function(pos)

            local meta = core.get_meta(pos)
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

        --[[
        on_metadata_inventory_move = function(
            pos, from_list, from_index, to_list, to_index, count, player
        )
            unilib.utils.log(
                "action",
                player:get_player_name() .. " moves items in simple box at " ..
                        core.pos_to_string(pos)
            )

        end,

        on_metadata_inventory_put = function(pos, listname, index, stack, player)

            unilib.utils.log(
                "action",
                player:get_player_name() .. " moves items to simple box at " ..
                        core.pos_to_string(pos)
            )

        end,

        on_metadata_inventory_take = function(pos, listname, index, stack, player)

            unilib.utils.log(
                "action",
                player:get_player_name() .. " takes items from simple box at " ..
                        core.pos_to_string(pos)
            )

        end,
        ]]--
    }

    unilib.utils.set_inventory_action_loggers(def_table, "simple box")
    unilib.register_node(
        -- From darkage:box
        "unilib:container_box_simple", "darkage:box", mode, def_table
    )

    -- (Original code used "default:wood" as the ingredient, but we will permit any kind of wood)
    unilib.register_craft({
        -- From darkage:box
        output = "darkage:box",
        recipe = {
            {"group:wood", "", "group:wood"},
            {"", "", ""},
            {"group:wood", "", "group:wood"},
        },
    })

end
