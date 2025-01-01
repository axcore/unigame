---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- read_csv_external.lua
--      Read standard CSV file external.csv
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function register_external_mods(folder_path)

    local external_path = folder_path .. "external.csv"
    local check_warning_flag = false

    if not unilib.utils.is_file(external_path) then

        -- (Only the last folder in the list is compulsory)
        if unilib.global.info_path_list[#unilib.global.info_path_list] == folder_path then

            unilib.utils.show_error(
                "../lib/system/read/read_csv_external.lua, register_external_mods():" ..
                        " Missing CSV file",
                external_path
            )

            unilib.read.fatal_error_flag = true

        end

        return

    end

    for i, csv_table in ipairs(unilib.utils.read_csv(external_path)) do

        local mod_name, modpack_name, url, notes, check = unpack(csv_table)

        if mod_name == nil or not string.find(mod_name, "%a") then

            -- (Do nothing for ignorable lines)

        elseif notes == nil then

            unilib.utils.show_warning(
                "../lib/system/read/read_csv_external.lua, register_external_mods():" ..
                        " Invalid line in CSV file",
                external_path,
                i
            )

        elseif unilib.global.external_mod_table[mod_name] then

            unilib.utils.show_warning(
                "../lib/system/read/read_csv_external.lua, register_external_mods():" ..
                        " Duplicate mod in CSV file (ignoring)",
                external_path,
                i
            )

        else

            -- Update the registry
            local data_table = {}

            -- The mod's name, e.g. "technic"
            data_table.mod_name = mod_name
            -- The name of the modpack, if any, e.g. "technic"
            data_table.modpack_name = modpack_name
            -- URL from which the mod can be downloaded
            data_table.url = url
            -- A brief summary of how unilib interacts with the mod
            data_table.notes = notes

            unilib.global.external_mod_table[mod_name] = data_table

        end

        if not check_warning_flag and check ~= nil then

            unilib.utils.show_warning(
                "../lib/system/read/read_csv_external.lua, register_external_mods():" ..
                        " Extra columns in CSV (ignoring them)",
                external_path,
                i
            )

            check_warning_flag = true

        end

    end

end

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

-- Read CSVs and register external mods
for _, folder_path in ipairs(unilib.global.info_path_list) do
    register_external_mods(folder_path)
end
