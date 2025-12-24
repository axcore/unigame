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

function unilib.furniture._convert_to_container(data_table, old_rows, old_descrip, old_label)

    -- Adapted from moreblocks:empty_shelf and xdecor:multishelf
    -- Converts any suitable item into a container
    --
    -- data_table compulsory fields:
    --      full_name (str): The item to be converted, e.g. "unilib:furniture_shelf_utility_acacia"
    --
    -- data_table optional fields:
    --      description (str): A translated description, e.g. S("Utility Shelf"). If not specified,
    --          "Container" is used
    --      label (str): A string (untranslated and in lower case) to be used in unilib.utils.log()
    --          messages, for example "utility shelf". If not specified, "container" is used
    --      rows (int): The number of rows in the container's inventory, in the range 1-4. If not
    --          specified, or if an invalid value is specified, then 4 is used
    --      columns (int): The number of columns in the container's inventory, in the range 1-8. If
    --          not specified, or if an invalid value is specified, then 4 is used

    -- N.B. Backwards compatibility with code before v1.1.0, when the argument list was in the form
    --      (full_name, rows, description, label)
    if type(data_table) == "string" then

        data_table = {
            full_name = data_table,
            description = old_descrip,
            label = old_label,
            rows = old_rows,
            columns = nil,          -- Not specified befoer v1.0.007
        }

    end

    local full_name = data_table.full_name

    local description = data_table.description or S("Container")
    local label = data_table.label or "container"
    local rows = data_table.rows or 4
    local columns = data_table.columns or 8

    if rows == nil or tonumber(rows) ~= rows or rows < 1 or rows > 4 then
        rows = 4
    end

    if columns == nil or tonumber(columns) ~= columns or columns < 1 or columns > 8 then
        columns = 8
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

            inv:set_size("main", rows * columns)
            meta:set_string("infotext", description)

            local offset = 0 + (( 8 - columns ) * 0.5)

            if rows == 1 then

                meta:set_string(
                    "formspec",
                    "size[8,6]" ..
                    "list[context;main;" .. offset .. ",0.3;8,1;]" ..
                    "list[current_player;main;0,1.85;8,1;]" ..
                    "list[current_player;main;0,3.08;8,3;8]" ..
                    "listring[current_player;main]" ..
                    "listring[context;main]"
                )

            elseif rows == 2 then

                meta:set_string(
                    "formspec",
                    "size[8,7]" ..
                    "list[context;main;" .. offset .. ",0.3;8,2;]" ..
                    "list[current_player;main;0,2.85;8,1;]" ..
                    "list[current_player;main;0,4.08;8,3;8]" ..
                    "listring[current_player;main]" ..
                    "listring[context;main]"
                )

            elseif rows == 3 then

                meta:set_string(
                    "formspec",
                    "size[8,8]" ..
                    "list[context;main;" .. offset .. ",0.3;8,3;]" ..
                    "list[current_player;main;0,3.85;8,1;]" ..
                    "list[current_player;main;0,5.08;8,3;8]" ..
                    "listring[current_player;main]" ..
                    "listring[context;main]"
                )

            else

                meta:set_string(
                    "formspec",
                    "size[8,9]" ..
                    "list[context;main;" .. offset .. ",0.3;8,4;]" ..
                    "list[current_player;main;0,4.85;8,1;]" ..
                    "list[current_player;main;0,6.08;8,3;8]" ..
                    "listring[current_player;main]" ..
                    "listring[context;main]"
                )

            end

        end,

        on_metadata_inventory_move = function(
            pos, from_list, from_index, to_list, to_index, count, player
        )
            unilib.utils.log(
                "action",
                player:get_player_name() .. " moves items in " .. label .. " at " ..
                        core.pos_to_string(pos)
            )

        end,

        on_metadata_inventory_put = function(pos, listname, index, stack, player)

            unilib.utils.log(
                "action",
                player:get_player_name() .. " moves items to " .. label .. " at " ..
                        core.pos_to_string(pos)
            )

        end,

        on_metadata_inventory_take = function(pos, listname, index, stack, player)

            unilib.utils.log(
                "action",
                player:get_player_name() .. " takes items from " .. label .. " at " ..
                        core.pos_to_string(pos)
                )

        end,
    })

end
