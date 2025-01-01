---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- read_csv_updated.lua
--      Read standard CSV file updated.csv
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function register_updated_mods(folder_path)

    local updated_path = folder_path .. "updated.csv"
    local check_warning_flag = false

    if not unilib.utils.is_file(updated_path) then

        -- (Only the last folder in the list is compulsory)
        if unilib.global.info_path_list[#unilib.global.info_path_list] == folder_path then

            unilib.utils.show_error(
                "../lib/system/read/read_csv_updated.lua, register_updated_mods():" ..
                        " Missing CSV file",
                updated_path
            )

            unilib.read.fatal_error_flag = true

        end

        return

    end

    for i, csv_table in ipairs(unilib.utils.read_csv(updated_path)) do

        local mod_name, modpack_name, update_date, update_notes, check = unpack(csv_table)

        if mod_name == nil or not string.find(mod_name, "%a") then

            -- (Do nothing for ignorable lines)

        elseif update_notes == nil then

            unilib.utils.show_warning(
                "../lib/system/read/read_csv_updated.lua, register_updated_mods():" ..
                        " Invalid line in CSV file",
                updated_path,
                i
            )

        elseif unilib.global.source_mod_table[mod_name] == nil then

            unilib.utils.show_warning(
                "../lib/system/read/read_csv_updated.lua, register_updated_mods():" ..
                        " Updated mod has no source mod in CSV file (ignoring)",
                updated_path,
                i
            )

        else

            -- Update the registry

            -- Date on which an updated version of the mod was downloaded, in the form "YYYYMMDD"
            unilib.global.source_mod_table[mod_name]["update_date"] = update_date
            -- A brief summary of what was updated
            unilib.global.source_mod_table[mod_name]["update_notes"] = update_notes

        end

        if not check_warning_flag and check ~= nil then

            unilib.utils.show_warning(
                "../lib/system/read/read_csv_updated.lua, register_updated_mods():" ..
                        " Extra columns in CSV (ignoring them)",
                updated_path,
                i
            )

            check_warning_flag = true

        end

    end

end

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

-- Read CSVs and register updated mods
for _, folder_path in ipairs(unilib.global.info_path_list) do
    register_updated_mods(folder_path)
end
