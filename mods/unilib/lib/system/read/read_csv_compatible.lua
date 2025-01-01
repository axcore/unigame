---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- read_csv_compatible.lua
--      Read standard CSV file compatible.csv
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function register_compatible_mods(folder_path)

    local compatible_path = folder_path .. "compatible.csv"
    local check_warning_flag = false

    if not unilib.utils.is_file(compatible_path) then

        -- (Only the last folder in the list is compulsory)
        if unilib.global.info_path_list[#unilib.global.info_path_list] == folder_path then

            unilib.utils.show_error(
                "../lib/system/read/read_csv_compatible.lua, register_compatible_mods():" ..
                        " Missing CSV file",
                compatible_path
            )

            unilib.read.fatal_error_flag = true

        end

        return

    end

    for i, csv_table in ipairs(unilib.utils.read_csv(compatible_path)) do

        local mod_name, modpack_name, url, notes, check = unpack(csv_table)

        if mod_name == nil or not string.find(mod_name, "%a") then

            -- (Do nothing for ignorable lines)

        elseif notes == nil then

            unilib.utils.show_warning(
                "../lib/system/read/read_csv_compatible.lua, register_compatible_mods():" ..
                        " Invalid line in CSV file",
                compatible_path,
                i
            )

        elseif unilib.global.compatible_mod_table[mod_name] then

            unilib.utils.show_warning(
                "../lib/system/read/read_csv_compatible.lua, register_compatible_mods():" ..
                        " Duplicate mod in CSV file (ignoring)",
                compatible_path,
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

            unilib.global.compatible_mod_table[mod_name] = data_table

        end

        if not check_warning_flag and check ~= nil then

            unilib.utils.show_warning(
                "../lib/system/read/read_csv_compatible.lua, register_compatible_mods():" ..
                        " Extra columns in CSV (ignoring them)",
                compatible_path,
                i
            )

            check_warning_flag = true

        end

    end

end

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

-- Read CSVs and register compatible mods
for _, folder_path in ipairs(unilib.global.info_path_list) do
    register_compatible_mods(folder_path)
end
