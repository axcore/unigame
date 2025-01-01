---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- furniture_convert.lua
--      Convert suitable items to containers
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Convert suitable items to containers
---------------------------------------------------------------------------------------------------

function unilib.furniture._convert_to_container(full_name, rows, description, label)

    -- Adapted from moreblocks:empty_shelf and xdecor:multishelf
    -- Converts any suitable item into a container
    --
    -- Args:
    --      full_name (str): The item to be converted, e.g. "unilib:furniture_shelf_utility_acacia"
    --
    -- Optional args:
    --      rows (int): The number of rows in the container's inventory - 1, 2 3 or 4 (corresponding
    --          to 8, 16, 24 or 32 items). If not one of those values or if not specified, then 4 is
    --          used
    --      description (str): A translated description, e.g. S("Utility Shelf"). If not specified,
    --          "Container" is used
    --      label (str): A label to be used in unilib.utils.log() messages, for example
    --          "utility shelf". If not specified, "container" is used

    if rows == nil or tonumber(rows) ~= rows then
        rows = 4
    end

    if description == nil then
        description = S("Container")
    end

    if label == nil then
        label = "container"
    end

    unilib.override_item(full_name, {

        can_dig = function(pos)

            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()
            return inv:is_empty("main")

        end,

        on_blast = function(pos)

            local drops = {}
            unilib.misc.get_inventory_drops(pos, "main", drops)
            drops[#drops + 1] = full_name
            core.remove_node(pos)
            return drops

        end,

        on_construct = function(pos)

            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()

            if rows == 1 then

                meta:set_string(
                    "formspec",
                    "size[8,6]" ..
                    "list[context;main;0,0.3;8,1;]" ..
                    "list[current_player;main;0,1.85;8,1;]" ..
                    "list[current_player;main;0,3.08;8,3;8]" ..
                    "listring[current_player;main]" ..
                    "listring[context;main]"
                )
                inv:set_size("main", 8)

            elseif rows == 2 then

                meta:set_string(
                    "formspec",
                    "size[8,7]" ..
                    "list[context;main;0,0.3;8,2;]" ..
                    "list[current_player;main;0,2.85;8,1;]" ..
                    "list[current_player;main;0,4.08;8,3;8]" ..
                    "listring[current_player;main]" ..
                    "listring[context;main]"
                )
                inv:set_size("main", 16)

            elseif rows == 3 then

                meta:set_string(
                    "formspec",
                    "size[8,8]" ..
                    "list[context;main;0,0.3;8,3;]" ..
                    "list[current_player;main;0,3.85;8,1;]" ..
                    "list[current_player;main;0,5.08;8,3;8]" ..
                    "listring[current_player;main]" ..
                    "listring[context;main]"
                )
                inv:set_size("main", 24)

            else

                meta:set_string(
                    "formspec",
                    "size[8,9]" ..
                    "list[context;main;0,0.3;8,4;]" ..
                    "list[current_player;main;0,4.85;8,1;]" ..
                    "list[current_player;main;0,6.08;8,3;8]" ..
                    "listring[current_player;main]" ..
                    "listring[context;main]"
                )
                inv:set_size("main", 32)

            end

            meta:set_string("infotext", description)

        end,

        on_metadata_inventory_move = function(
            pos, from_list, from_index, to_list, to_index, count, player
        )
            -- N.B. Not in original code
            unilib.utils.log(
                "action",
                player:get_player_name() .. " moves items in " .. label .. " at " ..
                        core.pos_to_string(pos)
            )

        end,

        on_metadata_inventory_put = function(pos, listname, index, stack, player)

            -- N.B. Not in original code
            unilib.utils.log(
                "action",
                player:get_player_name() .. " moves items to " .. label .. " at " ..
                        core.pos_to_string(pos)
            )

        end,

        on_metadata_inventory_take = function(pos, listname, index, stack, player)

            -- N.B. Not in original code
            unilib.utils.log(
                "action",
                player:get_player_name() .. " takes items from " .. label .. " at " ..
                        core.pos_to_string(pos)
                )

        end,
    })

end
