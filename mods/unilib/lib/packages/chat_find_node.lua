---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_find_node = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

-- The radius of the default search area (producing an search area of 201x201x201)
local default_size = 100
-- The search area is searched in segments of this radius
local segment_size = 100
-- The name and position of the nearest node found, during the last successful search
local target_name
local target_pos

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function find_node(pname, param, verbose_flag)

    local player = core.get_player_by_name(pname)
    if not player then
        return false, unilib.constant.chat_offline_msg
    end

    -- Check valid arguments
    local param_list = unilib.utils.split_string_by_whitespace(param)

    local pattern = param_list[1]
    if pattern == nil or pattern == "" then
        return false, S("You must specify a pattern matching a node (try /list_nodes)")
    end

    local width = tonumber(param_list[2])
    if width == nil then

        width = default_size

    elseif width < 1 then

        return false,
                S("Invalid width (omit the width to use the default value of @1)", default_size)

    end

    local height = tonumber(param_list[3])
    if height == nil then

        height = default_size

    elseif height < 1 then

        return false,
                S("Invalid height (omit the height to use the default value of @1)", default_size)

    end

    -- Compile a list of nodes matching the pattern; if the user specified an actual node (e.g.
    --      "unilib:stone_ordinary"), then it's a list of 1
    local node_list = {}
    if string.sub(pattern, 1, 6) == "group:" then

        local group = string.sub(pattern, 7)
        for full_name, _ in pairs(core.registered_nodes) do

            if core.get_item_group(full_name, group) > 0 then
                table.insert(node_list, full_name)
            end

        end

        if #node_list == 0 then
            return false, S("No registered node with the group \"@1\"", group)
        end

    elseif core.registered_nodes[pattern] ~= nil then

        table.insert(node_list, pattern)

    else

        for full_name, _ in pairs(core.registered_nodes) do

            if string.find(full_name, pattern) then
                table.insert(node_list, full_name)
            end

        end

        if #node_list == 0 then
            return false, S("No registered node matching the pattern \"@1\"", pattern)
        end

    end

    -- Set the overall search area
    local player_pos = player:get_pos()
    local min_x = player_pos.x - width
    local max_x = player_pos.x + width
    local min_y = player_pos.y - height
    local max_y = player_pos.y + height
    local min_z = player_pos.z - width
    local max_z = player_pos.z + width

    -- Search that area, one segment at a time (each segment should take a fraction of a second)
    local found_table = {}
    local found_count = 0
    local nearest_name, nearest_pos, nearest_distance

    for x = min_x, max_x, segment_size do

        for y = min_y, max_y, segment_size do

            for z = min_z, max_z, segment_size do

                -- Adjust the size of this segment so we don't search outside the overall search
                --      area
                local x1 = x
                local x2 = x + segment_size - 1
                if x2 > max_x then
                    x2 = max_x
                end

                local y1 = y
                local y2 = y + segment_size - 1
                if y2 > max_y then
                    y2 = max_y
                end

                local z1 = z
                local z2 = z + segment_size - 1
                if z2 > max_z then
                    z2 = max_z
                end

                -- Find matching nodes in this segment
                local result_table = core.find_nodes_in_area(
                    {x = x1, y = y1, z = z1},
                    {x = x2, y = y2, z = z2},
                    node_list,
                    true
                )

                -- Update the table of node positions
                for full_name, pos_list in pairs(result_table) do

                    found_count = found_count + #pos_list
                    if found_table[full_name] == nil then

                        found_table[full_name] = pos_list

                    else

                        for _, this_pos in ipairs(pos_list) do
                            table.insert(found_table[full_name], this_pos)
                        end

                    end

                    -- Update the nearest found node, if appropriate
                    for _, this_pos in pairs(pos_list) do

                        local distance = vector.distance(player_pos, this_pos)
                        if nearest_distance == nil or distance < nearest_distance then

                            nearest_name = full_name
                            nearest_pos = this_pos
                            nearest_distance = distance

                        end

                    end

                end

            end

        end

    end

    if found_count == 0 then

        -- No nodes found; disable teleportation to the nearest node from the previous search
        target_name = nil
        target_pos = nil
        return false, S("No matching nodes found within the search area")

    end

    -- Allow teleportation to the nearest found node
    target_name = nearest_name
    target_pos = nearest_pos

    -- Display results
    if not verbose_flag then

        unilib.utils.chat_send_player(
            pname,
            S(
                "Matching nodes found: @1, nearest: @2, position: x=@3 y=@4 z=@5, distance: @6)",
                found_count,
                nearest_name,
                nearest_pos.x,
                nearest_pos.y,
                nearest_pos.z,
                math.floor(nearest_distance)
            )
        )

    else

        for _, full_name in ipairs(unilib.utils.sort_table(found_table)) do

            unilib.utils.chat_send_player(
                pname,
                full_name .. " [" .. #found_table[full_name] .. "]"
            )

            for i, this_pos in ipairs(found_table[full_name]) do

                unilib.utils.chat_send_player(
                    pname,
                    "   x=" .. this_pos.x .. " y=" .. this_pos.y .. " z: " .. this_pos.z
                )

            end

        end

        unilib.utils.chat_send_player(
            pname,
            S(
                "End of list (matching nodes found: @1, nearest: @2, position: x=@3 y=@4 z=@5," ..
                        " distance: @6)",
                found_count,
                nearest_name,
                nearest_pos.x,
                nearest_pos.y,
                nearest_pos.z,
                math.floor(nearest_distance)
            )
        )

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_find_node.init()

    return {
        description = "Chat command /find_node, /find_nodes, /find_all_nodes, /teleport_to_node",
        notes = "Searches an area for matching nodes, and then teleport to the nearest one",
    }

end

function unilib.pkg.chat_find_node.exec()

    core.register_chatcommand("find_node", {
        params = S("<pattern> [width] [height]"),
        description = S(
            "Finds the closest node matching the specified name, pattern or group (e.g." ..
                    " unilib:flower_rose_red, flower, group:flower) within @1 blocks of the" ..
                    " player's position (or within the specified width and height)",
            default_size
        ),
        privs = {unilib_admin = true},

        func = function(name, param)
            return find_node(name, param, false)
        end,
    })

    core.register_chatcommand("find_nodes", {
        params = S("<pattern> [width] [height]"),
        description = S(
            "Finds the closest node matching the specified name, pattern or group (e.g." ..
                    " unilib:flower_rose_red, flower, group:flower) within @1 blocks of the" ..
                    " player's position (or within the specified width and height)",
            default_size
        ),
        privs = {unilib_admin = true},

        func = function(name, param)
            return find_node(name, param, false)
        end,
    })

    core.register_chatcommand("find_all_nodes", {
        params = S("<pattern> [width] [height]"),
        description = S(
            "Finds all nodes matching the specified name, pattern or group (e.g." ..
                    " unilib:flower_rose_red, flower, group:flower) within @1 blocks of the" ..
                    " player's position (or within the specified width and height)",
            default_size
        ),
        privs = {unilib_admin = true},

        func = function(name, param)
            return find_node(name, param, true)
        end,
    })

    core.register_chatcommand("teleport_to_node", {
        params = "",
        description = S(
            "Teleports to the location of the nearest node found during the most recent" ..
                    " search (using /find_node, etc). May teleport you into solid rock," ..
                    " so use with caution!"
        ),
        privs = {unilib_admin = true},

        func = function(name, param)

            local player = core.get_player_by_name(name)
            if not player then
                return false, unilib.constant.chat_offline_msg
            elseif target_pos == nil then
                return false,
                        S("No matching nodes found during the previous search (try /find_node)")
            end

            player:set_pos({x = target_pos.x, y = target_pos.y + 1, z = target_pos.z})
            unilib.utils.chat_send_player(
                name,
                S(
                    "Teleporting @1 to @2 at @3,@4,@5",
                    name,
                    target_name,
                    target_pos.x,
                    target_pos.y,
                    target_pos.z
                )
            )

        end,
    })

end
