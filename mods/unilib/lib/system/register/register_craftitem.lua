---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- register_craftitem.lua
--      Register craftitems using a replacement for the Minetest registration function
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Register craftitems
---------------------------------------------------------------------------------------------------

function unilib.register_craftitem(full_name, orig_name, replace_mode, def_table)

    -- Original to unilib
    -- N.B. There is no unilib.register._register_craftitem()
    --
    -- Packages should call this function to register a craftitem, rather than calling
    --      core.register_craftitem() directly
    --
    -- N.B. If the calling code accdientally uses the original argument list of
    --      core.register_craftitem(), i.e. (full_name, def_table), then this function will still
    --      register the item
    --
    -- Args:
    --      full_name (str): e.g. "unilib:mineral_coal_lump"
    --      orig_name (nil, str or list): e.g. "default:coal_lump"
    --      replace_mode (str): "add", "defer", "replace" or "hide"
    --
    -- Optional args:
    --      def_table (table): Usual definition table for the craftitem. If omitted, then we assume
    --          that core.register_craftitem() has already been called for some reason, so it is not
    --          called a second time. However, the rest of the code in this function is executed as
    --          normal (aliases are created, unilib global variables are updated, and so on). See
    --          the "mineral_mese" package for a practical example of a node that calls this
    --          function without specifying a definition table
    --
    -- Return values:
    --      The specified full_name

    -- Standard argument check
    if def_table == nil then

        if replace_mode == nil then

            -- Assume that the "def_table" argument was not omitted on purpose
            unilib.utils.show_error(
                "unilib.register_craftitem(): Invalid arguments, ignoring craftitem", full_name
            )

            return

        -- If the user has supplied arguments in the format expected by core.register_craftitem(),
        --      then we can still register this craftitem
        elseif type(orig_name) == "table" then

            unilib.utils.show_warning(
                "unilib.register_craftitem(): Invalid arguments, recovering craftitem definition" ..
                        " table",
                full_name
            )

            def_table = table.copy(orig_name)
            orig_name = ""
            replace_mode = unilib.default_replace_mode

        end

    elseif core.registered_craftitems[full_name] ~= nil then

        unilib.utils.show_warning(
            "unilib.register_craftitem(): Duplicate craftitem registration",
            full_name
        )

    end

    -- "orig_name" can be nil, a string or a list. Convert to a list, and register the relationship
    --      between the old and new craftitems
    local orig_name_list = unilib.utils.convert_to_list(orig_name)

    unilib.global.craftitem_deconvert_table[full_name] = orig_name_list
    for _, this_orig_name in ipairs(orig_name_list) do
        unilib.global.craftitem_convert_table[this_orig_name] = full_name
    end

    -- Register the craftitem with Minetest (unless core.register_craftitem() has already been
    --      called, for some reason)
    if def_table ~= nil then
        core.register_craftitem(full_name, def_table)
    end

    -- Handle craftitems that must be replaced/hidden
    if replace_mode == "hide" then
        unilib.register.hide_item(full_name, orig_name_list)
    elseif replace_mode == "replace" then
        unilib.register.replace_item(full_name, orig_name_list)
    end

    -- Register minetest aliases for each craftitem in a standard way
    for mod_name, item_name in string.gmatch(full_name, "([%w_]+):([%w_]+)") do
        core.register_alias(item_name, full_name)
    end

    -- Update global variables
    if unilib.global.current_pkg ~= nil then
        unilib.global.craftitem_parent_table[full_name] = unilib.global.current_pkg
    end

    -- (The original calling function might need this for its craft recipes)
    return full_name

end
