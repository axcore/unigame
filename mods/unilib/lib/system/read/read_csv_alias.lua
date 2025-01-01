---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- read_csv_alias.lua
--      Register backup aliases for minetest_game items
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function register_mtgame_aliases()

    -- Read the pre-generated CSV, mapping minetest_game nodes/craftitems/tools onto their
    --      unilib equivalents
    -- This is used to generate aliases, in case the unilib equivalents are not created

    local source_path = unilib.core.path_mod .. "/csv/convert/convert.csv"

    if not unilib.utils.is_file(source_path) then

        unilib.utils.show_warning(
            "../lib/system/read/read_csv_alias.lua, register_mtgame_aliases():" ..
                    " Missing CSV file",
            source_path
        )

        -- (Not a fatal error)
        return

    end

    for i, csv_table in ipairs(unilib.utils.read_csv(source_path)) do

        local orig_name, unilib_name = unpack(csv_table)

        -- (Do nothing for ignorable lines)
        if orig_name ~= nil and string.find(orig_name, "%a") then

            unilib.global.mtgame_convert_table[orig_name] = unilib_name
            unilib.global.mtgame_deconvert_table[unilib_name] = orig_name

        end

    end

end

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

-- Register backup aliases for minetest_game items
register_mtgame_aliases()
