---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_dump_mod = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_dump_mods(pname, param)

    -- Basic check
    if unilib.utils.is_table_empty(unilib.global.source_mod_table) then
        return false, S("No source mods are specified by source.csv")
    end

    -- Filter out non-matching mods
    local filtered_list = {}
    for _, mod_name in ipairs(unilib.utils.sort_table(unilib.global.source_mod_table)) do

        local source_data_table = unilib.global.source_mod_table[mod_name]

        if param == "" or
                string.find(mod_name, param) or
                string.find(source_data_table.modpack_name, param) then

            table.insert(filtered_list, mod_name)

        end

    end

    if #filtered_list == 0 then
        return false, S("No mods matching \"@1\" found in source.csv", param)
    end

    -- Show details about source mods (from the files ../csv/mods/source.csv, imported.csv and
    --      updated.csv)
    unilib.utils.chat_send_player(pname, S("Source mods (* = updated) (# = loaded) [modpack name]"))

    for _, mod_name in ipairs(filtered_list) do

        local source_data_table = unilib.global.source_mod_table[mod_name]
        -- (All keys in unilib.global.source_mod_table also exist in
        --      unilib.global.imported_mod_table)
        local imported_data_table = unilib.global.imported_mod_table[mod_name]

        local column, modpack_name
        if source_data_table.update_date == nil then
            column = "  "
        else
            column = " *"
        end

        if not imported_data_table.loaded_flag then
            column = column .. "  "
        else
            column = column .. "# "
        end

        if source_data_table.modpack_name == nil or source_data_table.modpack_name == "" then
            modpack_name = ""
        else
            modpack_name = " [" .. source_data_table.modpack_name .. "]"
        end

        unilib.utils.chat_send_player(pname, column .. mod_name .. modpack_name)

        unilib.utils.chat_send_player(pname, "       Download date: " .. source_data_table.date)
        if source_data_table.update_date ~= nil then

            unilib.utils.chat_send_player(
                pname, "       Update date:   " .. source_data_table.update_date
            )

        end

        unilib.utils.chat_send_player(pname, "       Source URL:    " .. source_data_table.url)
        unilib.utils.chat_send_player(pname, "       Author(s):     " .. source_data_table.author)
        unilib.utils.chat_send_player(pname, "       Code license:  " .. source_data_table.code)
        unilib.utils.chat_send_player(pname, "       Media license: " .. source_data_table.media)
        if source_data_table.notes ~= "" then

            unilib.utils.chat_send_player(
                pname, "       Notes:         " .. source_data_table.notes
            )

        end

        if source_data_table.update_date ~= nil and source_data_table.notes ~= "" then

            unilib.utils.chat_send_player(
                pname, "       Update notes:  " .. source_data_table.update_notes
            )

        end

        unilib.utils.chat_send_player(
            pname, "       Detect mode:   " .. imported_data_table.detect_mode
        )
        unilib.utils.chat_send_player(
            pname, "       Replace mode:  " .. imported_data_table.replace_mode
        )
        unilib.utils.chat_send_player(
            pname, "       Add mode:      " .. imported_data_table.add_mode
        )
        unilib.utils.chat_send_player(
            pname, "       Hide mode:     " .. imported_data_table.hide_mode
        )
        unilib.utils.chat_send_player(pname, "       Import notes:  " .. imported_data_table.notes)

    end

    unilib.utils.chat_send_player(pname, S("End of list (source mods found: @1)", #filtered_list))

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_dump_mod.init()

    return {
        description = "Chat commands /dump_mods, /dump_mod",
        notes = "Dumps details about all source mods, or just the specified source mod",
    }

end

function unilib.pkg.chat_dump_mod.exec()

    core.register_chatcommand("dump_mods", {
        params = "[mod]",
        description = S("Dumps details about all source mods, or just the specified source mod"),
        privs = {unilib_admin = true},

        func = function(name, param)
            return do_dump_mods(name, param)
        end,
    })

    core.register_chatcommand("dump_mod", {
        params = "[mod]",
        description = S("Dumps details about all source mods, or just the specified source mod"),
        privs = {unilib_admin = true},

        func = function(name, param)
            return do_dump_mods(name, param)
        end,
    })

end
