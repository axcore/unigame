---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- read_csv_imported.lua
--      Read standard CSV file imported.csv
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function register_imported_mods(folder_path)

    local imported_path = folder_path .. "imported.csv"
    local check_warning_flag = false

    if not unilib.utils.is_file(imported_path) then

        -- (Only the last folder in the list is compulsory)
        if unilib.global.info_path_list[#unilib.global.info_path_list] == folder_path then

            unilib.utils.show_error(
                "../lib/system/read/read_csv_imported.lua, register_imported_mods():" ..
                        " Missing CSV file",
                imported_path
            )

            unilib.read.fatal_error_flag = true

        end

        return

    end

    for i, csv_table in ipairs(unilib.utils.read_csv(imported_path)) do

        local mod_name, detect_mode, replace_mode, notes, check = unpack(csv_table)

        if mod_name == nil or not string.find(mod_name, "%a") then

            -- (Do nothing for ignorable lines)

        elseif notes == nil then

            unilib.utils.show_warning(
                "../lib/system/read/read_csv_imported.lua, register_imported_mods():" ..
                        " Invalid line in CSV file",
                imported_path,
                i
            )

        elseif unilib.global.imported_mod_table[mod_name] then

            unilib.utils.show_warning(
                "../lib/system/read/read_csv_imported.lua, register_imported_mods():" ..
                        " Duplicate mod in CSV file (ignoring)",
                imported_path,
                i
            )

        elseif detect_mode ~= "detect" and detect_mode ~= "ignore" then

            unilib.utils.show_warning(
                "../lib/system/read/read_csv_imported.lua, register_imported_mods():" ..
                        " Invalid detect mode in CSV file (should be \"detect\" or \"ignore\")" ..
                        " (ignoring)",
                imported_path,
                i
            )

        elseif replace_mode ~= "add" and replace_mode ~= "defer" and
                replace_mode ~= "replace" and replace_mode ~= "hide" then

            unilib.utils.show_warning(
                "../lib/system/read/read_csv_imported.lua, register_imported_mods():" ..
                        " Invalid replace mode in CSV file (should be \"add\", \"defer\"," ..
                        " \"replace\" or \"hide\")",
                imported_path,
                i
            )

        else

            -- Update the registry
            local data_table = {}

            -- The mod's name, e.g. "default"
            data_table.mod_name = mod_name
            -- Mod's detect mode, "detect" or "ignore"
            data_table.detect_mode = detect_mode

            -- Mod's replace mode, "defer", "add", "replace" or "hide"
            if unilib.setting.force_replace_flag and mod_name ~= "unilib" then

                -- If the Minetest setting is set, override the mod's replace mode. This never
                --      applies to any packages whose "source" mod is unilib
                data_table.replace_mode = "replace"
                data_table.add_mode = "replace"

            else

                data_table.replace_mode = replace_mode
                data_table.add_mode = replace_mode

            end

            -- true if Minetest has already loaded the mod, false if not (or if mod detection has
            --      not been enabled)
            if detect_mode == "detect" and core.get_modpath(mod_name) then

                data_table.loaded_flag = true

            else

                data_table.loaded_flag = false
                if replace_mode == "replace" or replace_mode == "hide" then

                    -- (Can't replace/hide a node/craftitem if its mod is not loaded)
                    data_table.add_mode = "add"

                end

            end

            -- Set hide mode
            if data_table.add_mode == "replace" then
                data_table.hide_mode = "hide"
            else
                data_table.hide_mode = data_table.add_mode
            end

            -- Any additional importation notes
            data_table.notes = notes

            unilib.global.imported_mod_table[mod_name] = data_table

        end

        if not check_warning_flag and check ~= nil then

            unilib.utils.show_warning(
                "../lib/system/read/read_csv_imported.lua, register_imported_mods():" ..
                        " Extra columns in CSV (ignoring them)",
                imported_path,
                i
            )

            check_warning_flag = true

        end

    end

end

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

-- Read CSVs and register imported mods
for _, folder_path in ipairs(unilib.global.info_path_list) do
    register_imported_mods(folder_path)
end
