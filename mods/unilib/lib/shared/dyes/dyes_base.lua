---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- dyes_base.lua
--      Base API functions for dyes
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Base API functions for dyes
---------------------------------------------------------------------------------------------------

function unilib.dyes._register_dye(data_table)

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
    --      palette_pos (int): position of this dye in unilib's standard palette,
    --          unilib_palette_dye_basic.png. If specified, a number in the range 1-15,
    --          representing the 15 basic dyes. The 0 value represents the "undyed" item, which in
    --          our palette is white
    --      translated_name (str): e.g. "Black" (used to create derivative nodes)
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Dye")
    local palette_pos = data_table.palette_pos or nil
    local translated_name = data_table.translated_name or S("Colour")

    local full_name = "unilib:dye_" .. part_name

    local group_table = {}
    group_table["dye"] = 1
    group_table["colour_" .. part_name] = 1
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
            {"group:flower,colour_" .. part_name}
        },
    })

    -- Update global variables
    unilib.global.dye_description_table[part_name] = translated_name
    if palette_pos ~= nil then
        unilib.global.dye_palette_table[full_name] = palette_pos
    end

    return full_name

end
