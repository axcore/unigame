---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- minerals_powder.lua
--      API functions for mineral powders
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- API functions for mineral powders
---------------------------------------------------------------------------------------------------

function unilib.minerals._register_mineral_powder(data_table)

    -- Adapted from technic/technic/machines/register/grinder_recipes.lua
    -- Creates a mineral powder item (the equivalent to dust in technic's original code)
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "suilphur"
    --      orig_name (str): e.g. "technic:sulfur_dust"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Sulphur Powder"
    --      lump_time (int): Grinding time for converting lumps into powder, in seconds
    --
    -- Return values:
    --      The full_name of the new craftitem, or nil if technic is not available

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Mineral Powder")
    local lump_time = data_table.lump_time or 3

    local full_name = "unilib:mineral_" .. part_name .. "_powder"

    if unilib.setting.technic_update_flag then

        unilib.register_craftitem(full_name, orig_name, replace_mode, {
            description = description,
            inventory_image = "unilib_mineral_" .. part_name .. "_powder.png",
        })
        technic.register_grinder_recipe({
            output = "unilib:mineral_" .. part_name .. "_powder " ..
                    tostring(unilib.setting.technic_grind_mineral_ratio),
            input = {"unilib:mineral_" .. part_name .. "_lump"},
            time = lump_time,
        })

        return full_name

    else

        return nil

    end

end
