---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- utils_list_table.lua
--      List/table utility functions
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function prepare_table(t, indent)

    if not indent then
        indent = 0
    end

    local toprint = "{\r\n"
    indent = indent + 4
    for k, v in pairs(t) do

        toprint = toprint .. string.rep(" ", indent)
        if (type(k) == "number") then
            toprint = toprint .. "[" .. k .. "] = "
        elseif (type(k) == "string") then
            toprint = toprint .. k ..  " = "
        end

        if v == false then
            toprint = toprint .. "false,\r\n"
        elseif v == true then
            toprint = toprint .. "true,\r\n"
        elseif (type(v) == "number") then
            toprint = toprint .. v .. ",\r\n"
        elseif (type(v) == "string") then
            toprint = toprint .. "\"" .. v .. "\",\r\n"
        elseif (type(v) == "table") then
            toprint = toprint .. prepare_table(v, indent) .. ",\r\n"
        else
            toprint = toprint .. "\"" .. tostring(v) .. "\",\r\n"
        end

    end

    toprint = toprint .. string.rep(" ", indent - 4) .. "}"

    return toprint

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.utils._clone_simple_table(data_table)

    -- Assumes a simple key/value table structure, for example one used in the .groups field of a
    --      core.register_node() call

    local t = {}
    for k, v in pairs(data_table) do
        t[k] = v
    end

    return t

end

function unilib.utils._convert_to_list(arg)

    -- "arg" is expected to be either nil, a string, or a list
    -- Returns a list (the original one, or a list containing the string, or an empty list)
    -- Note that, when "arg" is nil or an empty string, then returns an empty list

    if type(arg) == "table" then

        -- Already a list
        return arg

    elseif arg == nil or arg == "" then

        -- For nil/empty strings, return an empty list
        return {}

    else

        -- Convert the string to a list
        return { arg }

    end

end

function unilib.utils._convert_to_string(arg)

    -- "arg" is expected to be either nil, a scalar value, a list, or a list of lists (but not a
    --      table)
    -- If a list of lists, then a mixture of mini-lists and scalar values is acceptable, e.g.
    --      { {a, b, c}, d, {e, f, g} }
    -- Returns "arg" converted to a string (if originally a list, concatenated as a string)

    if type(arg) == "table" then

        local str = ""
        for _, value in ipairs(arg) do

            if type(value) ~= "table" then

                if str == "" then
                    str = value
                else
                    str = str .. ", " .. value
                end

            else

                local mini_str = ""
                for _, this_value in pairs(value) do

                    if mini_str == "" then
                        mini_str = "{" .. this_value
                    else
                        mini_str = mini_str .. ", " .. this_value
                    end

                end

                if mini_str ~= "" then

                    mini_str = mini_str .. "}"
                    if str == "" then
                        str = mini_str
                    else
                        str = str .. ", " .. mini_str
                    end

                end

            end

        end

        return str

    else

        return tostring(arg)

    end

end

function unilib.utils._get_table_size(t)

    -- Returns the number of keys in a table (which does not need to be a list)

    local count = 0
    for _ in pairs(t) do
        count = count + 1
    end

    return count

end

function unilib.utils._is_table_empty(t)

    -- Although the "correct" way to check for an empty lua table is
    --      if not next(table) then
    -- ..., a call to this function clarifies that the calling code is actually checking for an
    --      empty table, and not just testing whether the value is nil, or not

    for _, _ in pairs(t) do
        return false
    end

    return true

end

function unilib.utils._is_value_in_list(arg, list)

    -- Checks whether an argument appears in a list (sequential table), or not
    --
    -- Args:
    --      arg (any): The item to check
    --      list (list): The list to check
    --
    -- Return values:
    --      true if arg appears in list, false if not

    for _, v in ipairs(list) do

        if arg == v then
            return true
        end

    end

    return false

end

function unilib.utils._is_value_scalar_or_in_list(arg, value)

    -- Checks whether an argument matches a scalar value, or appears in a list value (sequential
    --      table)
    --
    -- Args:
    --      arg (any): The item to check
    --      value (scalar or list): The matching item to check

    if type(value) == "table" then
        return unilib.utils.is_value_in_list(arg, value)
    elseif arg == value then
        return true
    else
        return false
    end

end

function unilib.utils._reverse_list(list)

    -- Reverses the order of items in a list, e.g. {1, 7, 3, 10} becomes {10, 3, 7, 1}
    --
    -- Args:
    --      list (list): The list to reverse
    --
    -- Return values:
    --      The reversed list

    for i = 1, math.floor(#list / 2), 1 do
        list[i], list[#list - i + 1] = list[#list - i + 1], list[i]
    end

    return list

end

function unilib.utils._show_table(t, title)

    -- Adapted from https://stackoverflow.com/questions/41942289/display-contents-of-tables-in-lua
    -- Formats a table for display. The output looks better in Minetest's debug.txt file, but is
    --      readable in the chat window
    --
    -- Args:
    --      t (table): The table to display
    --
    -- Optional args:
    --      title (str): A title to display, if required

    -- Sanity checks
    if type(t) ~= "table" then

        unilib.utils.show_error("unilib.print_table(): Cannot print this data type as a table")
        return

    end

    -- Print the table
    local output = "\r\n"
    if title ~= nil and title ~= "" then
        output = output .. title .. "\r\n"
    end

    output = output .. prepare_table(t)

    core.log(output)

end

function unilib.utils._show_table_in_chat(pname, t, title)

    -- Modified version of unilib.utils.show_table(), for use with chat commands
    -- This version uses core.chat_send_player() instead of core.log()
    --
    -- THIS FUNCTION SHOULD NOT BE CALLED DURING STARTUP, as no players will be connected. If
    --      necessary, you could do this:
    --
    --          local function foobar()
    --              for i, player in ipairs(core.get_connected_players()) do
    --                  local pname = player:get_player_name()
    --                  unilib.utils.show_table_in_chat(pname, TABLE)
    --              end
    --          end
    --
    --          core.after(1, foobar)
    --
    -- Args:
    --      pname (str): The player's name
    --      t (table): The table to display
    --
    -- Optional args:
    --      title (str): A title to display, if required

    -- Sanity checks
    if type(t) ~= "table" then

        core.chat_send_player(
            pname,
            string.format("Cannot print the data type %s as a table", type(t))
        )

        return

    end

    -- Print the table
    local output = "\r\n"
    if title ~= nil and title ~= "" then
        output = output .. title .. "\r\n"
    end

    output = output .. prepare_table(t)

    unilib.utils.chat_send_player(pname, output)

end

function unilib.utils._sort_table(t)

    local list = {}
    for key in pairs(t) do
        table.insert(list, key)
    end

    table.sort(list)

    return list

end

function unilib.utils._test_equivalence_of_lists(list1, list2)

    -- Test equivalence of two lists
    --
    -- Args:
    --      list1, list2 (table): The lists to compare
    --
    -- Return values:
    --      If at least one value appears in both lists, returns true. Otherwise returns false

    local table1 = {}
    for _, v in ipairs(unilib.utils.convert_to_list(list1)) do
        table1[v] = true
    end

    local table2 = {}
    for _, v in ipairs(unilib.utils.convert_to_list(list2)) do
        table2[v] = true
    end

    for k, _ in pairs(table1) do

        if table2[k] == nil then

            -- list1 contains values not in list2
            return false

        else

            table2[k] = nil

        end

    end

    if not unilib.utils.is_table_empty(table2) then

        -- list2 contains values not in list1
        return false

    else

        -- list1, list2 are equivalent
        return true

    end

end

function unilib.utils._test_junction_of_lists(list1, list2)

    -- Test junction of two lists
    --
    -- Args:
    --      list1, list2 (table): The lists to compare
    --
    -- Return values:
    --      If at least one value appears in both lists, returns true. Otherwise returns false

    local adj_list1 = unilib.utils.convert_to_list(list1)
    local adj_list2 = unilib.utils.convert_to_list(list2)

    for _, value1 in ipairs(adj_list1) do

        for _, value2 in ipairs(adj_list2) do

            if value1 == value2 then
                return true
            end

        end

    end

    return false

end
