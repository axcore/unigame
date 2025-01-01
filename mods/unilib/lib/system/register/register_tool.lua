---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- register_tool.lua
--      Register tools using a replacement for the Minetest registration function
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Register tools
---------------------------------------------------------------------------------------------------

function unilib.register_tool(full_name, orig_name, replace_mode, def_table)

    -- Original to unilib
    -- N.B. There is no unilib.register._register_tool()
    --
    -- Packages should call this function to register a tool, rather than calling
    --      core.register_tool() directly
    --
    -- Args:
    --      full_name (str): e.g. "unilib:tool_pick_steel"
    --      orig_name (nil, str or list): e.g. "default:pick_steel"
    --      replace_mode (str): "add", "defer", "replace" or "hide"
    --      def_table (table): Usual definition table for the tool
    --
    -- Return values:
    --      The specified full_name

    -- Standard argument check (in case the package writer has forgotten to add "orig_name" and
    --      "replace_mode")
    if def_table == nil then

        -- If the user has supplied arguments in the format expected by core.register_tool(), then
        --      we can still register this node
        if type(orig_name) == "table" then

            unilib.utils.show_warning(
                "unilib.register_tool(): Invalid arguments, recovering tool definition table",
                full_name
            )

            def_table = table.copy(orig_name)
            orig_name = ""
            replace_mode = unilib.default_replace_mode

        else

            unilib.utils.show_error(
                "unilib.register_tool(): Invalid arguments, ignoring tool", full_name
            )

            return

        end

    elseif core.registered_nodes[full_name] ~= nil then

        unilib.utils.show_warning(
            "unilib.register_tool(): Duplicate tool registration",
            full_name
        )

    end

    -- "orig_name" can be nil, a string or a list. Convert to a list, and register the relationship
    --      between the old and new nodes
    local orig_name_list = unilib.utils.convert_to_list(orig_name)

    unilib.global.tool_deconvert_table[full_name] = orig_name_list
    for _, this_orig_name in ipairs(orig_name_list) do
        unilib.global.tool_convert_table[this_orig_name] = full_name
    end

    -- Register the tool with Minetest
    core.register_tool(full_name, def_table)

    -- Handle tools that must be replaced/hidden
    if replace_mode == "hide" then
        unilib.register.hide_item(full_name, orig_name_list)
    elseif replace_mode == "replace" then
        unilib.register.replace_item(full_name, orig_name_list)
    end

    -- Register minetest aliases for each tool in a standard way
    for mod_name, item_name in string.gmatch(full_name, "([%w_]+):([%w_]+)") do
        core.register_alias(item_name, full_name)
    end

    -- Update global variables
    if unilib.global.current_pkg ~= nil then
        unilib.global.tool_parent_table[full_name] = unilib.global.current_pkg
    end

    -- (The original calling function might need this for its craft recipes)
    return full_name

end
