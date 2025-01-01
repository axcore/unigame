---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- minerals_update.lua
--      Mineral update functions
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Mineral update functions
---------------------------------------------------------------------------------------------------

function unilib.minerals._update_mineral(data_table)

    -- Original to unilib
    -- Updates the global variable set in an earlier call to unilib.register_mineral()
    --
    -- data_table compulsory fields:
    --      part_name (str): A key in unilib.global.mineral_table, e.g. "cinnabar"
    --
    -- data_table optional fields:
    --      Any of the fields available in the unilib.register_mineral() call, except for .part_name

    if data_table.part_name == nil or unilib.global.mineral_table[data_table.part_name] == nil then

        unilib.utils.show_error(
            "unilib.minerals.update_mineral(): Unrecognised mineral type",
            data_table.part_name
        )

        return

    end

    for _, field in ipairs({
        "description", "fictional_flag", "gem_flag", "hardness", "metal_list", "no_lump_flag",
        "non_metal_list", "powder_flag", "rock_flag"
    }) do
        if data_table[field] ~= nil then
            unilib.global.mineral_table[data_table.part_name][field] = data_table[field]
        end

    end

end
