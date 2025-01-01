---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- dyes_register.lua
--      Dyed item registry functions
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Dyed item registry functions
---------------------------------------------------------------------------------------------------

function unilib.dyes._register_node_with_dye(full_name, orig_name, replace_mode, def_table)

    -- Original to unilib
    -- Updates a node definition so that it can be coloured, either airbrush from the unifieddyes
    --      mod (if available), or with basic dyes (if the "dye_basic" package has been loaded)
    -- Then registers the node via a call to unilib.register_node(), as usual
    -- If neither basic dyes nor the unifieddyes mod are available, registers the node without
    --      changes
    --
    -- data_table compulsory fields:
    --      full_name (str): e.g. "unilib:glass_milk_rhombus"
    --      orig_name (nil, str or list): e.g. "darkage:milk_glass"
    --      replace_mode (str): "add", "defer", "replace" or "hide"
    --      def_table (table): A partial definition table for the node. This functions adds fields
    --          required by unifieddyes, e.g. .palette

    if unilib.setting.unifieddyes_update_flag then

        -- Add unifieddye's required fields
        local group_table = def_table.groups
        if group_table == nil then
            group_table = {}
        end

        group_table.ud_param2_colorable = 1
        def_table.palette = "unifieddyes_palette_extended.png"
        def_table.paramtype2 = "color"

        -- Register the node with Minetest
        unilib.register_node(full_name, orig_name, replace_mode, def_table)
        -- On success, register the node with unifieddyes
        if core.registered_nodes[full_name] ~= nil then

            unifieddyes.register_color_craft({
                type = "shapeless",
                output = full_name,
                recipe = {full_name, "MAIN_DYE"},

                palette = "extended",
                neutral_node = "",
            })

        end

    elseif unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        -- Add required fields. def_table can specify its own palette, if it doesn't want to use
        --      the standard one
        if def_table.palette == nil then
            def_table.palette = "unilib_palette_dye_basic.png"
        end

        def_table.paramtype2 = "colorwallmounted"

        def_table.after_place_node = unilib.dyes.item_after_place_node
        def_table.on_punch = unilib.dyes.item_on_punch
        def_table.on_rotate = unilib.dyes.item_on_rotate

        -- Register the node with Minetest
        unilib.register_node(full_name, orig_name, replace_mode, def_table)

    else

        -- Register the node without changes
        unilib.register_node(full_name, orig_name, replace_mode, def_table)

    end

end

function unilib.dyes._register_craft_with_dye(full_name)

    -- Original to unilib
    -- Modified version of unilib.dyes.register_node_with_dye() for a node that already exists
    -- Registers the node with the unifieddyes mod so it can be colourised
    --
    -- data_table compulsory fields:
    --      full_name (str): e.g. "unilib:pane_glass_milk_rhombus"

    -- Basic checks
    if not unilib.setting.unifieddyes_update_flag or core.registered_nodes[full_name] == nil then
        return
    end

    local group_table = core.registered_nodes[full_name]["groups"]
    if group_table == nil then
        group_table = {}
    end

    group_table.ud_param2_colorable = 1

    -- Add unifieddye's required fields
    unilib.override_item(full_name, {
        groups = group_table,
        palette = "unifieddyes_palette_extended.png",
        paramtype2 = "color",
    })

    unifieddyes.register_color_craft({
        type = "shapeless",
        output = full_name,
        recipe = {full_name, "MAIN_DYE"},

        palette = "extended",
        neutral_node = "",
    })

end
