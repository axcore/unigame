---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    castle/castle_storage
-- Code:    MIT
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.container_box_storage = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.castle_storage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.container_box_storage.init()

    return {
        description = "Storage box",
        depends = "metal_steel",
    }

end

function unilib.pkg.container_box_storage.exec()

    local def_table = {
        description = S("Storage Box"),
        tiles = {
            "unilib_container_box_storage_top.png",
            "unilib_container_box_storage_top.png",
            "unilib_container_box_storage.png",
            "unilib_container_box_storage.png",
            "unilib_container_box_storage.png",
            "unilib_container_box_storage.png",
        },
        groups = {choppy = 3},
        sounds = unilib.global.sound_table.wood,

        drawtype = "normal",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        paramtype = "light",

        can_dig = function(pos,player)

            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()
            return inv:is_empty("main")

        end,

        -- N.B. No .on_blast() in original code
        on_blast = function() end,

        on_construct = function(pos)

            local meta = core.get_meta(pos)
            --[[
            meta:set_string("formspec",
                "size[8,9]" ..
                "list[current_name;main;0,0;8,5;]" ..
                "list[current_player;main;0,5;8,4;]"
            )
            ]]--
            meta:set_string("formspec",
                "size[8,8.7]" ..
                "list[current_name;main;0,0.2;8,5;]" ..
                "list[current_player;main;0,4.7;8,4;]" ..
                "listring[current_name;main]" ..
                "listring[current_player;main]"
            )
            meta:set_string("infotext", S("Storage Crate"))
            local inv = meta:get_inventory()
            inv:set_size("main", 8 * 4)

        end,

        --[[
        on_metadata_inventory_move = function(
            pos, from_list, from_index, to_list, to_index, count, player
        )
            unilib.utils.log(
                "action",
                player:get_player_name() .. " moves items in storage box at " ..
                        core.pos_to_string(pos)
            )

        end,

        on_metadata_inventory_put = function(pos, listname, index, stack, player)

            unilib.utils.log(
                "action",
                player:get_player_name() .. " moves items to storage box at " ..
                        core.pos_to_string(pos)
            )

        end,

        on_metadata_inventory_take = function(pos, listname, index, stack, player)

            unilib.utils.log(
                "action",
                player:get_player_name() .. " takes items from storage box at " ..
                        core.pos_to_string(pos)
            )

        end,
        ]]--
    }

    unilib.utils.set_inventory_action_loggers(def_table, "storage box")
    unilib.register_node(
        -- From castle_storage:crate
        "unilib:container_box_storage", "castle_storage:crate", mode, def_table
    )

    -- N.B. Original recipe used "default:wood"
    unilib.register_craft({
        -- From castle_storage:crate
        output = "unilib:container_box_storage",
        recipe = {
            {"group:wood", "group:wood", "group:wood"},
            {"group:wood", "unilib:metal_steel_ingot", "group:wood"},
        },
    })

end
