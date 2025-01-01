---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- register_node.lua
--      Register nodes using a replacement for the Minetest registration function
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Register nodes
---------------------------------------------------------------------------------------------------

function unilib.register_node(full_name, orig_name, replace_mode, def_table)

    -- Original to unilib
    -- N.B. There is no unilib.register._register_node()
    --
    -- Packages should call this function to register a node, rather than calling
    --      core.register_node() directly
    -- There is one exception: when creating an item that uses multiple nodes (such as a door), this
    --      function should only be called to register the item that appears in the player's
    --      inventory; the supplementary items should be registered with core.register_node() as
    --      usual
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      orig_name (nil, str or list): e.g. "default:stone"
    --      replace_mode (str): "add", "defer", "replace" or "hide"
    --      def_table (table): Usual definition table for the node
    --
    -- Return values:
    --      The specified full_name

    -- Standard argument check (in case the package writer has forgotten to add "orig_name" and
    --      "replace_mode")
    if def_table == nil then

        -- If the user has supplied arguments in the format expected by core.register_node(), then
        --      we can still register this node
        if type(orig_name) == "table" then

            unilib.utils.show_warning(
                "unilib.register_node(): Invalid arguments, recovering node definition table",
                full_name
            )

            def_table = table.copy(orig_name)
            orig_name = ""
            replace_mode = unilib.default_replace_mode

        else

            unilib.utils.show_error(
                "unilib.register_node(): Invalid arguments, ignoring node", full_name
            )

            return

        end

    elseif core.registered_nodes[full_name] ~= nil then

        unilib.utils.show_warning(
            "unilib.register_node(): Duplicate node registration",
            full_name
        )

    end

    -- "orig_name" can be nil, a string or a list. Convert to a list, and register the relationship
    --      between the old and new nodes
    local orig_name_list = unilib.utils.convert_to_list(orig_name)

    unilib.global.node_deconvert_table[full_name] = orig_name_list
    for _, this_orig_name in ipairs(orig_name_list) do
        unilib.global.node_convert_table[this_orig_name] = full_name
    end

    -- Register the node with Minetest
    core.register_node(full_name, def_table)

    -- Handle nodes that must be replaced/hidden
    if replace_mode == "hide" then
        unilib.register.hide_item(full_name, orig_name_list)
    elseif replace_mode == "replace" then
        unilib.register.replace_item(full_name, orig_name_list)
    end

    -- Register minetest aliases for each node in a standard way
    for mod_name, item_name in string.gmatch(full_name, "([%w_]+):([%w_]+)") do
        core.register_alias(item_name, full_name)
    end

    -- Update global variables
    if unilib.global.current_pkg ~= nil then
        unilib.global.node_parent_table[full_name] = unilib.global.current_pkg
    end

    -- (The original calling function might need this for its craft recipes)
    return full_name

end
