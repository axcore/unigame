---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- read_csv_source.lua
--      Read standard CSV file sources.csv
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function register_source_mods(folder_path)

    local source_path = folder_path .. "source.csv"
    local check_warning_flag = false

    if not unilib.utils.is_file(source_path) then

        -- (Only the last folder in the list is compulsory)
        if unilib.global.info_path_list[#unilib.global.info_path_list] == folder_path then

            unilib.utils.show_error(
                "../lib/system/read/read_csv_source.lua, register_source_mods(): Missing CSV file",
                source_path
            )

            unilib.read.fatal_error_flag = true

        end

        return

    end

    for i, csv_table in ipairs(unilib.utils.read_csv(source_path)) do

        local mod_name, modpack_name, dl_date, url, author, code, media, notes, check =
                unpack(csv_table)

        if mod_name == nil or not string.find(mod_name, "%a") then

            -- (Do nothing for ignorable lines)

        elseif notes == nil then

            unilib.utils.show_warning(
                "../lib/system/read/read_csv_source.lua, register_source_mods():" ..
                        " Invalid line in CSV file",
                source_path,
                i
            )

        elseif unilib.global.source_mod_table[mod_name] then

            unilib.utils.show_warning(
                "../lib/system/read/read_csv_source.lua, register_source_mods():" ..
                        " Duplicate mod in CSV file (ignoring)",
                source_path,
                i
            )

        else

            -- Update the registry
            local data_table = {}

            -- The mod's name, e.g. "default"
            data_table.mod_name = mod_name
            -- The name of the modpack, if any, e.g. "minetest_game"
            data_table.modpack_name = modpack_name
            -- Date on which the mod was downloaded, in the form "YYYYMMDD"
            data_table.date = dl_date
            -- URL from which the mod was downloaded
            data_table.url = url
            -- The lead author(s), e.g. "celeron55/Perttu Ahola"
            data_table.author = author
            -- The code licence, e.g. "LGPL 2.1"
            data_table.code = code
            -- The media licence, e.g. "CC BY-SA 3.0"
            data_table.media = media
            -- A brief summary of what has been imported
            data_table.notes = notes

            unilib.global.source_mod_table[mod_name] = data_table

        end

        if not check_warning_flag and check ~= nil then

            unilib.utils.show_warning(
                "../lib/system/read/read_csv_source.lua, register_source_mods():" ..
                        " Extra columns in CSV (ignoring them)",
                source_path,
                i
            )

            check_warning_flag = true

        end

    end

end

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

-- Read CSVs and register source mods
for _, folder_path in ipairs(unilib.global.info_path_list) do
    register_source_mods(folder_path)
end
