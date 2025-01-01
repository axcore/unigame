---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- utils_node_craftitem_tool.lua
--      Node/craftitem/tool utility functions (general)
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.utils._get_craftitem_field(full_name, field_name)

    -- Adapted from biome_lib/api.lua
    --
    -- Args:
    --      full_name (str): e.g. "unilib:mineral_coal_lump"
    --      field_name (str): e.g. "description"
    --
    -- Return values:
    --      Returns the value of the field, or nil if either the node or the field do not exist

    if not core.registered_craftitems[full_name] then
        return nil
    else
        return core.registered_craftitems[full_name][field_name]
    end

end

function unilib.utils._get_definition_and_group(full_name, group)

    -- Original to unilib
    -- Wrapper for unilib.utils.get_group() when it's not known whether the item "full_name" is a
    --      node, craftitem or tool
    -- If the specified item's definition table contains the specified group, return its number;
    --      otherwise return 0

    if core.registered_nodes[full_name] ~= nil then
        return unilib.utils.get_group(core.registered_nodes[full_name], group)
    elseif core.registered_craftitems[full_name] ~= nil then
        return unilib.utils.get_group(core.registered_craftitems[full_name], group)
    elseif core.registered_tools[full_name] ~= nil then
        return unilib.utils.get_group(core.registered_tools[full_name], group)
    else
        return 0
    end

end

function unilib.utils._get_group(def_table, group)

    -- Adapted from sickles/api.lua
    -- If the specified item's definition table contains the specified group, return its number;
    --      otherwise return 0

    if def_table == nil or
            def_table.groups == nil or
            def_table.groups[group] == nil then
        return 0
    else
        return def_table.groups[group]
    end

end

function unilib.utils._get_node_field(full_name, field_name)

    -- Adapted from biome_lib/api.lua
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      field_name (str): e.g. "description"
    --
    -- Return values:
    --      Returns the value of the field, or nil if either the node or the field do not exist

    if not core.registered_nodes[full_name] then
        return nil
    else
        return core.registered_nodes[full_name][field_name]
    end

end

function unilib.utils._get_tool_field(full_name, field_name)

    -- Adapted from biome_lib/api.lua
    --
    -- Args:
    --      full_name (str): e.g. "unilib:tool_pick_steel"
    --      field_name (str): e.g. "description"
    --
    -- Return values:
    --      Returns the value of the field, or nil if either the node or the field do not exist

    if not core.registered_tools[full_name] then
        return nil
    else
        return core.registered_tools[full_name][field_name]
    end

end

function unilib.utils._is_registered_node(arg)

    -- Original to unilib
    -- Checks whether one or more nodes all exist
    --
    -- Args:
    --      arg (str or list): One or more nodes
    --
    -- Return values:
    --      true if all the specified nodes exist, false if at least one of them does not, false if
    --          the argument is nil

    if arg == nil then
        return false
    end

    for _, full_name in pairs(unilib.utils.convert_to_list(arg)) do

        if core.registered_nodes[full_name] == nil then
            return false
        end

    end

    return true

end

function unilib.utils._is_registered_node_or_mtgame_alias(arg)

    -- Original to unilib
    -- Intended for code creating biomes, custom dirts, decorations, ores, etc, when the replace
    --      mode for minetest_game mods is "defer" (meaning that default:dirt exists in the world,
    --      rather than the expected unilib:dirt_ordinary)
    -- Checks whether unilib node(s) exist, or whether their minetest_game equivalents exist
    -- (The magic of Minetest aliases will take care of the rest, allowing us for example to create
    --      an ore whose .ore field is a minetest_game node, and whose .wherein field is a unilib
    --      node)
    --
    -- Args:
    --      arg (str or list): One or more nodes
    --
    -- Return values:
    --      true if all the specified nodes exist, false if at least one of them does not, false if
    --          the argument is nil

    if arg == nil then
        return false
    end

    for _, full_name in pairs(unilib.utils.convert_to_list(arg)) do

        if core.registered_nodes[full_name] == nil and (
            unilib.global.mtgame_deconvert_table[full_name] == nil or
            core.registered_nodes[unilib.global.mtgame_deconvert_table[full_name]] == nil
        ) then
            return false
        end

    end

    return true

end
