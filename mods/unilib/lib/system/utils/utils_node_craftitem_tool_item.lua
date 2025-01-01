---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- utils_node_craftitem_tool_item.lua
--      Node/craftitem/tool utility functions (item names)
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.utils._convert_item(full_name)

    -- Converts the name of a node, craftitem or tool from another mod to the unilib equivalent, if
    --      possible
    -- Filters out any items that are unregistered with Minetest, or which unilib has marked as
    --      hidden
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --
    -- Return values:
    --      Returns the unilib name (as a string, or nil if no item exists) and the original mod's
    --          names (as a list, which might be empty)

    local unilib_name = nil
    local orig_name_list = {}

    if unilib.global.node_convert_table[full_name] ~= nil then

        unilib_name = unilib.global.node_convert_table[full_name]
        orig_name_list = unilib.global.node_deconvert_table[unilib_name]

    elseif unilib.global.node_deconvert_table[full_name] ~= nil then

        unilib_name = full_name
        orig_name_list = unilib.global.node_deconvert_table[unilib_name]

    elseif unilib.global.craftitem_convert_table[full_name] ~= nil then

        unilib_name = unilib.global.craftitem_convert_table[full_name]
        orig_name_list = unilib.global.craftitem_deconvert_table[unilib_name]

    elseif unilib.global.craftitem_deconvert_table[full_name] ~= nil then

        unilib_name = full_name
        orig_name_list = unilib.global.craftitem_deconvert_table[unilib_name]

    elseif unilib.global.tool_convert_table[full_name] ~= nil then

        unilib_name = unilib.global.tool_convert_table[full_name]
        orig_name_list = unilib.global.tool_deconvert_table[unilib_name]

    elseif unilib.global.craftitem_deconvert_table[full_name] ~= nil then

        unilib_name = full_name
        orig_name_list = unilib.global.tool_deconvert_table[unilib_name]

    elseif unilib.utils.get_mod_name(full_name) == "unilib" then

        unilib_name = full_name

    else

        orig_name_list = {full_name}
    end

    -- Filter out any items which are hidden or not registered with Minetest
    if unilib_name and core.registered_items[unilib_name] == nil then
        unilib_name = nil
    end

    local adj_orig_name_list = {}
    for _, orig_name in pairs(orig_name_list) do

        if core.registered_items[orig_name] ~= nil and
                unilib.global.hidden_item_table[orig_name] == nil then

            table.insert(adj_orig_name_list, orig_name)

        end

    end

    return unilib_name, adj_orig_name_list

end

function unilib.utils._split_name(full_name)

    -- Extracts the mod name and item name from a a full node/craftitem/tool name, returning them
    --      as a list
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --
    -- Return values:
    --      e.g. { "unilib", "stone_ordinary" }, or an empty list full_name is not in the expected
    --          format

    -- Sanity check
    if full_name == nil or not string.find(full_name, ":") then
        return ""
    end

    local split_list = full_name:split(":")
    return split_list[1], split_list[2]

end

function unilib.utils._get_mod_name(full_name)

    -- Extracts a mod name from a full node/craftitem/tool name
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --
    -- Return values:
    --      e.g. "unilib", or an empty string if full_name is not in the expected format

    -- Sanity check
    if full_name == nil or not string.find(full_name, ":") then
        return ""
    end

    return full_name:split(":")[1]

end

function unilib.utils._get_item_name(full_name)

    -- Extracts a mod name from a full node/craftitem/tool name
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --
    -- Return values:
    --      e.g. "stone_ordinary", or an empty string if full_name is not in the expected format

    -- Sanity check
    if full_name == nil then
        return ""
    end

    return full_name:split(":")[2]

end

function unilib.utils._get_first_component(full_name)

    -- Extracts the first component of a full node/craftitem/tool name
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --
    -- Return values:
    --      e.g. "stone", or an empty string if full_name is not in the expected format

    -- Sanity check
    if full_name == nil then
        return ""
    end

    local mod_name = string.gsub(full_name, "^[^:]+:([^_]+)_.*", "%1")
    if mod_name == full_name then
        return ""
    else
        return mod_name
    end

end

function unilib.utils._get_last_component(full_name)

    -- Extracts the last component of a full node/craftitem/tool name
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --
    -- Return values:
    --      e.g. "ordinary", or an empty string if full_name is not in the expected format

    -- Sanity check
    if full_name == nil then
        return ""
    end

    local mod_name = string.gsub(full_name, "^.*_([^_]+)$", "%1")
    if mod_name == full_name then
        return ""
    else
        return mod_name
    end

end

function unilib.utils._get_item_and_multiple(item_str)

    -- Expects an item string with an optional quantity, e.g. "unilib:stone_ordinary" or
    --      "unilib:stone_ordinary 9"
    -- If the quantity is not specified, it is assumed to be 1
    --
    -- Args:
    --  item_str (str): The string described above
    --
    -- Return values:
    --      Returns two values: the full name of the item (a string), and its quantity (an integer)

    local full_name, multiple

    if string.find(item_str, "^[^%s]+%s+%d+$") then

        full_name = string.gsub(item_str, "^([^%s]+)%s+%d+$", "%1")
        multiple = string.gsub(item_str, "^.*%s+(%d+)$", "%1")

    else

        full_name = item_str
        multiple = 1

    end

    return full_name, tonumber(multiple)

end
