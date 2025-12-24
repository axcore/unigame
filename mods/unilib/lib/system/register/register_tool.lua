---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- register_tool.lua
--      Register tools using a replacement for the Minetest registration function
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function on_place_callback(itemstack, user, pointed_thing)

    -- From naturalslopes_minetest_game, was use_shape()
    -- Allow picks, shovels, axes and swords to shape natural slopes (by right-clicking nodes while
    --      wielding them)

    local tool_def_table = itemstack:get_definition()

    local node_pos = core.get_pointed_thing_position(pointed_thing, false)
    local node = core.get_node(node_pos)
    local node_def_table = core.registered_nodes[node.name]

    local dig_params = core.get_dig_params(node_def_table.groups, tool_def_table.tool_capabilities)
    if not dig_params.diggable then
        return itemstack
    end

    local chance = 1.0 / (dig_params.time * 2.0)
    if chance >= 1.0 or math.random() < chance then

        local changed_flag = unilib.slopes.update_shape(node_pos, node)

        if node_def_table.sounds.dug then
            core.sound_play(node_def_table.sounds.dug, {pos = node_pos}, true)
        end

        if changed_flag then
            itemstack:add_wear(math.ceil(dig_params.wear / 4.0))
        end

    else

        if node_def_table.sounds.dig then
            core.sound_play(node_def_table.sounds.dig, {to_player = user:get_player_name()}, true)
        elseif node_def_table.sounds.dug then
            core.sound_play(node_def_table.sounds.dug, {to_player = user:get_player_name()}, true)
        end

    end

    return itemstack

end

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
    -- N.B. If the calling code accdientally uses the original argument list of
    --      core.register_tool(), i.e. (full_name, def_table), then this function will still
    --      register the item
    --
    -- Args:
    --      full_name (str): e.g. "unilib:tool_pick_steel"
    --      orig_name (nil, str or list): e.g. "default:pick_steel"
    --      replace_mode (str): "add", "defer", "replace" or "hide"
    --
    -- Optional args:
    --      def_table (table): Usual definition table for the tool. If omitted, then we assume that
    --          core.register_tool() has already been called for some reason, so it is not called a
    --          second time. However, the rest of the code in this function is executed as normal
    --          (aliases are created, unilib global variables are updated, and so on). See the
    --          "mineral_mese" package for a practical example of a node that calls this function
    --          without specifying a definition table
    --
    -- Return values:
    --      The specified full_name

    -- Standard argument check
    if def_table == nil then

        if replace_mode == nil then

            -- Assume that the "def_table" argument was not omitted on purpose
            unilib.utils.show_error(
                "unilib.register_tool(): Invalid arguments, ignoring tool", full_name
            )

            return

        -- If the user has supplied arguments in the format expected by core.register_tool(), then
        --      we can still register this node
        elseif type(orig_name) == "table" then

            unilib.utils.show_warning(
                "unilib.register_tool(): Invalid arguments, recovering tool definition table",
                full_name
            )

            def_table = table.copy(orig_name)
            orig_name = ""
            replace_mode = unilib.default_replace_mode

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

    -- Allow picks, shovels, axes and swords to shape natural slopes (by right-clicking nodes while
    --      wielding them)
    if unilib.setting.slopes_enable_flag and def_table and def_table.groups and (
        def_table.groups.axe or
        def_table.groups.pickaxe or
        def_table.groups.shovel or
        def_table.groups.sword
    ) then
        def_table.on_place = on_place_callback
    end

    -- Register the tool with Minetest (unless core.register_tool() has already been called, for
    --      some reason)
    if def_table ~= nil then
        core.register_tool(full_name, def_table)
    end

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
