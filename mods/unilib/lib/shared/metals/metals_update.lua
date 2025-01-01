---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- metals_update.lua
--      Metal update functions
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Metal update functions
---------------------------------------------------------------------------------------------------

function unilib.metals._update_metal(data_table)

    -- Original to unilib
    -- Updates the global variable set in an earlier call to unilib.register_metal()
    --
    -- data_table compulsory fields:
    --      part_name (str): A key in unilib.global.metal_table, e.g. "tin"
    --
    -- data_table optional fields:
    --      Any of the fields available in the unilib.register_metal() call, except for .part_name

    if data_table.part_name == nil or unilib.global.metal_table[data_table.part_name] == nil then

        unilib.utils.show_error(
            "unilib.update_metal(): Unrecognised metal type", data_table.part_name
        )

        return

    end

    for _, field in ipairs({
        "description", "alloy_flag", "fictional_flag", "hardness", "powder_flag",
    }) do
        if data_table[field] ~= nil then
            unilib.global.metal_table[data_table.part_name][field] = data_table[field]
        end

    end

end

function unilib.metals._update_non_metal(data_table)

    -- Original to unilib
    -- Updates the global variable set in an earlier call to unilib.register_non_metal()
    --
    -- data_table compulsory fields:
    --      part_name (str): A key in unilib.global.non_metal_table, e.g. "nitrogen"
    --
    -- data_table optional fields:
    --      Any of the fields available in the unilib.register_non_metal() call, except for
    --          .part_name

    if data_table.part_name == nil or
            unilib.global.non_metal_table[data_table.part_name] == nil then

        unilib.utils.show_error(
            "unilib.update_non_metal(): Unrecognised elemental non-metal type", data_table.part_name
        )

        return

    end

    for _, field in ipairs({"description"}) do

        if data_table[field] ~= nil then
            unilib.global.non_metal_table[data_table.part_name][field] = data_table[field]
        end

    end

end
