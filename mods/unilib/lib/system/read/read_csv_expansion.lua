---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- read_csv_expansion.lua
--      Read standard CSV file expansion.csv
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function register_expansion_packs()

    -- N.B. Unlike the functions just above, external.csv is only found in unilib's folders

    local expansion_path = unilib.core.path_mod .. "/csv/mods/expansion.csv"
    local check_warning_flag = false

    if not unilib.utils.is_file(expansion_path) then

        unilib.utils.show_error(
            "../lib/system/read/read_csv_expansion.lua, register_expansion_packs():" ..
                    " Missing CSV file",
            expansion_path
        )

        unilib.read.fatal_error_flag = true
        return

    end

    for i, csv_table in ipairs(unilib.utils.read_csv(expansion_path)) do

        local mod_name, url, notes, check = unpack(csv_table)

        if mod_name == nil or not string.find(mod_name, "%a") then

            -- (Do nothing for ignorable lines)

        elseif notes == nil then

            unilib.utils.show_warning(
                "../lib/system/read/read_csv_expansion.lua, register_expansion_packs():" ..
                        " Invalid line in CSV file",
                expansion_path,
                i
            )

        elseif unilib.global.expansion_mod_table[mod_name] then

            unilib.utils.show_warning(
                "../lib/system/read/read_csv_expansion.lua, register_expansion_packs():" ..
                        " Duplicate mod in CSV file (ignoring)",
                expansion_path,
                i
            )

        else

            -- Update the registry
            unilib.global.expansion_mod_table[mod_name] = {
                mod_name = mod_name,
                url = url,
                notes = notes,
            }

        end

        if not check_warning_flag and check ~= nil then

            unilib.utils.show_warning(
                "../lib/system/read/read_csv_expansion.lua, register_imported_mods():" ..
                        " Extra columns in CSV (ignoring them)",
                expansion_path,
                i
            )

            check_warning_flag = true

        end

    end

end

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

-- Read CSVs and register expansion packs
register_expansion_packs()
