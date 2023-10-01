---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- dyes.lua
--      Set up shared functions for dyes
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Register dyes
---------------------------------------------------------------------------------------------------

function unilib.register_dye(data_table)

    -- Adapted from dye/init.lua
    -- Creates a dye craftitem in a specified colour and updates global variables
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "black"
    --      orig_name (str): e.g. "dye:black"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Black Dye"
    --      translated_name (str): e.g. "Black" (used to create derivative nodes)
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Dye")
    local translated_name = data_table.translated_name or S("Colour")

    local full_name = "unilib:dye_" .. part_name

    local group_table = {}
    group_table["dye"] = 1
    group_table["color_" .. part_name] = 1

    unilib.register_craftitem(full_name, orig_name, replace_mode, {
        description = description,
        inventory_image = "unilib_dye_" .. part_name .. ".png",
        groups = group_table,
    })
    -- (Craft dyes from any flower with the right group)
    unilib.register_craft({
        output = full_name .. " 4",
        recipe = {
            {"group:flower,color_" .. part_name}
        },
    })

    -- Update the unilib registry
    unilib.dye_table[part_name] = translated_name

    return full_name

end

---------------------------------------------------------------------------------------------------
-- Register nodes with unifieddyes
---------------------------------------------------------------------------------------------------

function unilib.register_node_with_dye(full_name, orig_name, replace_mode, def_table)

    -- Original to unilib
    -- Registers a node (via a call to unilib.register_node(), as usual), then registers that node
    --      with the unifieddyes mod, so that the new node can be colourised
    --
    -- data_table compulsory fields:
    --      full_name (str): e.g. "unilib:glass_milk_rhombus"
    --      orig_name (nil, str or list): e.g. "darkage:milk_glass"
    --      replace_mode (str): "add", "defer", "replace" or "hide"
    --      def_table (table): A partial definition table for the node. This functions adds fields
    --          required by unifieddyes, e.g. .palette

    -- Basic checks
    if not unilib.unifieddyes_update_flag then
        return
    end

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
    if minetest.registered_nodes[full_name] ~= nil then

        unifieddyes.register_color_craft({
            type = "shapeless",
            output = full_name,
            recipe = {full_name, "MAIN_DYE"},

            palette = "extended",
            neutral_node = "",
        })

    end

end

function unilib.register_craft_with_dye(full_name)

    -- Original to unilib
    -- Modified version of unilib.register_node_with_dye() for a node that alaredy exists
    -- Registers the node with the unifieddyes mod so it can be colourised
    --
    -- data_table compulsory fields:
    --      full_name (str): e.g. "unilib:pane_glass_milk_rhombus"

    -- Basic checks
    if not unilib.unifieddyes_update_flag or minetest.registered_nodes[full_name] == nil then
        return
    end

    local group_table = minetest.registered_nodes[full_name]["groups"]
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
